import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:get_it/get_it.dart';

/// Display the overview of the controller, without any interaction
class OverviewControllerFlame extends FlameGame with HasGameRef {
  OverviewControllerFlame({required this.path, CoddeBackend? backend})
      : _tmpBackend = backend;
  OverviewControllerFlame.preload(this.mapComponent) : path = "";
  String path;
  CoddeBackend? _tmpBackend;
  Component? mapComponent;
  late CustomProperties props;
  final controllerWidgetMode = ControllerWidgetMode.dummy;

  CoddeBackend get backend {
    try {
      return _tmpBackend ?? GetIt.I.get<CoddeBackend>();
    } on WaitingTimeOutException {
      throw NoRegsiteredBackendException();
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (mapComponent == null) {
      String content = '';
      try {
        await backend.read(path).then((value) => value.forEach((element) {
              content += "$element\n";
            }));
        logger.d("OVERVIEW: $content");
      } catch (e) {
        // TODO: export no map found error
        mapComponent = TextComponent(
          text: 'No map found',
          textRenderer: flameTextRenderer,
          anchor: Anchor.topCenter,
          position: Vector2(size.x / 2, size.y / 2),
        );
        add(mapComponent!);
        return;
      }
      try {
        mapComponent = await CoddeTiledComponent.load(content,
            mode: controllerWidgetMode, scale: Vector2.all(0.75));
      } catch (e) {
        mapComponent = TextComponent(
          text: 'Invalid map: $e',
          textRenderer: flameTextRenderer,
          anchor: Anchor.topCenter,
          position: Vector2(size.x / 2, size.y / 2),
        );
      }

      if (mapComponent != null &&
          (mapComponent as CoddeTiledComponent).tileMap.map.layers.isEmpty) {
        mapComponent = TextComponent(
          text: "Wow! it's empty here",
          textRenderer: flameTextRenderer,
          anchor: Anchor.topCenter,
          position: Vector2(size.x / 2, size.y / 2),
        );
      }
    }
    final dummyProtocol =
        FlameCoddeProtocol(protocol: Protocol.webSocket, address: '');
    dummyProtocol.add(mapComponent!);
    add(dummyProtocol);
  }
}
