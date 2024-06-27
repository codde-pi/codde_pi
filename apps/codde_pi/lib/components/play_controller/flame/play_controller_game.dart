import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart' as material;

class PlayControllerGame extends FlameGame with HasGameRef {
  Project project;
  bool executeMain;

  PlayControllerGame({required this.project, this.executeMain = true});

  String? get remoteDestination => project.remoteDestination;
  Device get device => project.device;
  String get workDir => project.workDir;

  late TiledComponent mapComponent;
  SFTPBackend? backend;
  late CustomProperties props;
  String?
      errorMessage; // TODO create mixin to propagate widget errors to this game

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // launch main
    try {
      if (executeMain) {
        backend = SFTPBackend(credentials: device.host?.toCredentials());
        await backend!.open();
        await backend!.ssh
            .execute(getExecutablePath(workDir: remoteDestination!))
            .then((value) => value.stderr.listen((event) {
                  errorMessage = event.toString();
                  overlays.add('Notification');
                }))
            .onError((error, stackTrace) {
          throw ExecutionException(error.toString());
        });
      }
    } catch (e) {
      logger.e("Execution failed: $e");
      errorMessage = e.toString();
      overlays.add('Notification');
      // TODO: create notify service instead
    }
    if (overlays.isActive('Notification')) {
      return;
    }
    // GetIt.I.registerSingleton<SFTPBackend>(backend!);
    // read map
    String content =
        await getLocalBackend().readSync(getControllerName(path: workDir));
    mapComponent = await CoddeTiledComponent.load(content,
        mode: ControllerWidgetMode.player);
    // load props
    try {
      props = mapComponent.tileMap.map.properties;
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    // TODO: remove assert, disable run button and show snackbar warning
    final view =
        PlayControllerView(protocol: device.protocol, address: device.addr);
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

  Future<Widget> overlayBuilder(BuildContext context) async {
    await Flame.device.fullScreen();
    // TODO: set Protrait/Landscape
    return Scaffold(
      body: GameWidget<PlayControllerGame>(
        game: this,
        initialActiveOverlays: const ['Loading'],
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
    backend?.close();
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
  PlayControllerView({required super.protocol, required super.address});
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
