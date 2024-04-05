import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class PlayControllerGame extends FlameGame with HasGameRef {
  String path;

  PlayControllerGame(this.path);

  late TiledComponent mapComponent;
  final backend = GetIt.I.get<CoddeBackend>();
  late CustomProperties props;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    String content = '';
    await backend.read(path).then((value) => value.forEach((element) {
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
    final Device? device =
        Hive.box<Device>("devices").get(props!.getValue<int>("deviceId"));
    if (device != null) {
      // TODO: remove assert, disable run button and show snackbar warning
      assert(device.address != null, "Address is not device :(");
      assert(device.protocol != null, "No protocol specified :/");
      final view = PlayControllerView(
          path: path, protocol: device.protocol, address: device.address!);
      try {
        await view.com.connect();
      } catch (e) {
        logger.e(e);
        overlays.remove('Loading');
        add(TextComponent(text: "Connection failed", anchor: Anchor.center));
        return;
      } finally {
        overlays.remove('Loading');
      }

      view.add(mapComponent);
      add(view);
    } else {
      add(TextComponent(text: "No linked device found", anchor: Anchor.center));
    }
  }

  @override
  void onMount() {
    super.onMount();
    print('$runtimeType onMount');
    logger.d('$runtimeType assign $props');

    // TODO: useful ? remove ?
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
    GetIt.I.get<CoddeCom>().disconnect();
    // exit fullscreen
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Go back
    Navigator.of(context).pop();
  }

  Widget _loadingOverlay(context, game) =>
      const Center(child: CircularProgressIndicator());
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