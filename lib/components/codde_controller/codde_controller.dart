import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/codde_widgets/api/widget_parser.dart';
import 'package:codde_pi/components/codde_controller/views/codde_device_overview.dart';
import 'package:codde_pi/components/codde_controller/views/edit_controller_page.dart';
import 'package:codde_pi/components/utils/no_map_found.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:controller_widget_api/models/controller_properties.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../dynamic_bar/dynamic_bar.dart';
import 'flame/codde_tiled_component.dart';
import 'flame/overview_controller_flame.dart';
import 'store/codde_controller_store.dart';

export 'bloc/edit_controller_bloc.dart';
export 'store/std_controller_store.dart';
export 'store/edit_controller_store.dart';
export 'store/play_controller_store.dart';
export 'store/codde_controller_store.dart';
export 'flame/edit_controller_flame.dart';
export 'views/edit_controller_outline.dart';
export 'flame/play_controller_game.dart';
import 'package:flame_tiled/flame_tiled.dart' as tiled;

class CoddeController extends DynamicBarStatefulWidget {
  CoddeController({super.key});

  @override
  DynamicBarStateWidget createDynamicState() => _CoddeController();
}

class _CoddeController extends DynamicBarStateWidget<CoddeController>
    with SingleTickerProviderStateMixin {
  late tiled.TiledComponent mapComponent;
  late ControllerProperties properties;
  late String path;
  late CoddeBackend backend = getBackend();
  final controllerWidgetProvider =
      ControllerWidgetProvider(ControllerWidgetMode.overview);

  @override
  void setFab(BuildContext context) {
    bar.setFab(
        iconData: Icons.play_arrow,
        action: () => Navigator.of(context).pushNamed('/codde/player'));
  }

  Future<tiled.TiledComponent> getMap() async {
    String content = '';
    await backend
        .read(getControllerName(path))
        .then((value) => value.forEach((element) {
              content += "$element\n";
            }));
    return await CoddeTiledComponent.load(content,
        provider: controllerWidgetProvider);
  }

  void assignValues() {
    // load props
    try {
      properties =
          ControllerProperties(mapComponent.tileMap.map.properties.byName);
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    final Device? device =
        Hive.box<Device>("devices").get(properties.getValue<int>("deviceId"));
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.8),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));
  late final _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final store = Provider.of<CoddeControllerStore>(context);
    final coddeProject = /* context
        .watch<CoddeState>()
        .project; // */
        Provider.of<CoddeState>(context).project;
    if (coddeProject == null) {
      throw RuntimeProjectException();
    }
    path = coddeProject.path;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(coddeProject.name), leading: Container()),
          body: FutureBuilder(
              future: getMap(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("ERROR: ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == null) {
                  return NoMapFound(setState: setState);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // ALL RIGHT !
                mapComponent = snapshot.data!;
                assignValues();

                return GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dy < 0) {
                      _controller.forward();
                    } else if (details.delta.dy > 0) {
                      _controller.reverse();
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: (MediaQuery.of(context).size.width / 1.5) *
                                (MediaQuery.of(context).devicePixelRatio),
                            child: GameWidget(
                                game: OverviewControllerFlame.preload(
                                    mapComponent)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: (MediaQuery.of(context).size.width / 2) -
                            ((MediaQuery.of(context).size.width / 1.5) / 2),
                        child: IconButton(
                            onPressed: () async {
                              final controller = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (_) => EditControllerPage(
                                          path: getControllerName(path))));
                              if (controller != null) setState(() {});
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                      const SizedBox(height: widgetGutter),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).padding.top +
                                  kToolbarHeight +
                                  kBottomNavigationBarHeight),
                          child: CoddeDeviceOverview(
                              deviceId: properties.getValue<int>('deviceId')),
                        ),
                      ),
                      // CoddeDeviceDialog(properties: properties),
                    ],
                  ),
                );
              })),
    );
  }

  @override
  List<DynamicBarMenuItem> get bottomMenu => [
        DynamicBarMenuItem(
            name: "Controller",
            iconData: Icons.gamepad,
            destination: DynamicBarPager.controller),
        if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Dashboard",
              iconData: Icons.dashboard,
              destination: DynamicBarPager.dashboard),
        if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Terminal",
              iconData: Icons.terminal,
              destination: DynamicBarPager.terminal),
        DynamicBarMenuItem(
            name: "Diagram",
            iconData: Icons.schema,
            destination: DynamicBarPager.diagram),
        DynamicBarMenuItem(name: "Exit", iconData: Icons.exit_to_app)
      ];

  @override
  void setIndexer(BuildContext context) {
    bar.setIndexer((p0) => updateMenu(context, p0));
  }

  void updateMenu(context, int index) {
    if (index == getLastMenuIndex) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      bar.selectMenuItem(index);
    }
  }
}
