import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/codde_widgets/api/widget_parser.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/utils/no_map_found.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

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
export 'views/std_controller_view.dart';
export 'flame/play_controller_game.dart';
import 'package:flame_tiled/flame_tiled.dart' as tiled;

class CoddeController extends DynamicBarStatefulWidget {
  CoddeController({super.key});

  @override
  DynamicBarStateWidget createDynamicState() => _CoddeController();
}

class _CoddeController extends DynamicBarStateWidget<CoddeController> {
  late tiled.TiledComponent mapComponent;
  late tiled.CustomProperties properties;
  late String path;
  get backend => GetIt.I.get<CoddeBackend>();
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
      properties = mapComponent.tileMap.map.properties;
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    final Device? device =
        Hive.box<Device>("devices").get(properties.getValue<int>("deviceId"));
  }

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

    print('project path = ${coddeProject.path}');
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(coddeProject.name)),
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

                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        // TODO: insert MAX_WIDTH
                        child: GameWidget(
                            game:
                                OverviewControllerFlame.preload(mapComponent)))
                  ],
                ));
              })),
    );
  }
}
