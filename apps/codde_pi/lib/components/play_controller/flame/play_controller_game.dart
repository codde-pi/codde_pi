import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart' as material;

class PlayControllerGame extends FlameGame with HasGameRef {
  String workDir;
  Device device;
  bool executeMain;

  PlayControllerGame(
      {required this.workDir, required this.device, this.executeMain = true});

  late TiledComponent mapComponent;
  CoddeBackend? backend;
  late CustomProperties props;
  String?
      errorMessage; // TODO create mixin to propagate widget errors to this game

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // launch main
    try {
      if (executeMain) {
        backend = CoddeBackend(BackendLocation.server,
            credentials: device.host?.toCredentials());
        backend?.client?.execute(getExecutablePath(workDir: workDir));
      }
    } catch (e) {
      errorMessage = e.toString();
      overlays.add('Notification');
      // TODO: create notify service instead
    }
    // read map
    String content = '';
    await GetIt.I
        .get<CoddeBackend>()
        .read(getControllerName(path: workDir))
        .then((value) => value.forEach((element) {
              content += "$element\n";
            }));
    mapComponent = await CoddeTiledComponent.load(content,
        mode: ControllerWidgetMode.player);
    // load props
    try {
      props = mapComponent.tileMap.map.properties;
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    // TODO: remove assert, disable run button and show snackbar warning
    assert(device.addr != null, "Address is not device :(");
    assert(device.protocol != null, "No protocol specified :/");
    final view = PlayControllerView(
        path: workDir, protocol: device.protocol, address: device.addr!);
    try {
      await view.com.connect();
    } catch (e) {
      logger.e(e);
      overlays.remove('Loading');
      // add(TextComponent(text: "Connection failed", anchor: Anchor.center));
      errorMessage = e.toString();
      overlays.add('Notification');
      return;
    } finally {
      overlays.remove('Loading');
    }

    view.add(mapComponent);
    add(view);
  }

  @override
  void onMount() {
    super.onMount();
    print('$runtimeType onMount');
    logger.d('$runtimeType assign $props');

    // serve controller properties for parent widgets
    if (GetIt.I.isRegistered<ControllerProperties>()) {
      GetIt.I.unregister<ControllerProperties>();
    }
    GetIt.I.registerLazySingleton(() => ControllerProperties(props.byName));
  }

  Future<Widget> overlayBuilder(BuildContext context) async {
    await Flame.device.fullScreen();
    // TODO: set Protrait/Landscape
    return Scaffold(
      body: GameWidget<PlayControllerGame>(
        game: this,
        initialActiveOverlays: ['Loading'],
        overlayBuilderMap: {
          'Loading': _loadingOverlay,
          'Notification': _notificationOverlay
        },
      ),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async => exitRun(context),
              icon: const Icon(Icons.exit_to_app))),
    );
  }

  Future exitRun(BuildContext context) async {
    // Stop codde protocol execution
    if (GetIt.I.isRegistered<CoddeCom>()) GetIt.I.get<CoddeCom>().disconnect();
    // exit fullscreen
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Go back
    Navigator.of(context).pop();
  }

  Widget _loadingOverlay(context, game) => const Center(
      child: Padding(
          padding: EdgeInsets.all(widgetGutter),
          child: CircularProgressIndicator()));

  Widget _notificationOverlay(context, game) {
    return Padding(
      padding: const EdgeInsets.all(widgetGutter),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(widgetGutter / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  material.Text('Error',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.error)),
                  IconButton(
                    onPressed: () {
                      overlays.remove('Notification');
                    },
                    icon: const material.Icon(Icons.close),
                  ),
                ],
              ),
              Container(child: material.Text(errorMessage ?? '')),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayControllerView extends FlameCoddeProtocol {
  String path;
  PlayControllerView(
      {required this.path, required super.protocol, required super.address});
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    if (GetIt.I.isRegistered<CoddeCom>()) GetIt.I.unregister<CoddeCom>();
    GetIt.I.registerSingleton(com);
  }

  @override
  void onConnect() {
    print('Now connected !');
  }

  @override
  void onDisconnect() {
    print('Sorry, disconnected :/');
  }
}
