import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xml/xml.dart';

class OverviewControllerFlame extends FlameGame with HasGameRef {
  OverviewControllerFlame({required this.path, CoddeBackend? backend})
      : this._tmp_backend = backend;
  OverviewControllerFlame.preload(this.mapComponent) : path = "";
  String path;
  CoddeBackend? _tmp_backend;
  Component? mapComponent;
  late CustomProperties props;
  final controllerWidgetProvider =
      ControllerWidgetProvider(ControllerWidgetMode.overview);

  CoddeBackend get backend {
    try {
      return _tmp_backend ?? GetIt.I.get<CoddeBackend>();
    } on WaitingTimeOutException {
      throw NoRegsiteredBackendException();
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (mapComponent == null) {
      String content = '';
      await backend.read(path).then((value) => value.forEach((element) {
            content += "$element\n";
          }));
      try {
        mapComponent = await CoddeTiledComponent.load(content,
            provider: controllerWidgetProvider, scale: Vector2.all(0.5));
      } catch (e) {
        print('MAP $content');
        mapComponent = TextComponent(
          text: 'Invalid map: $e',
          textRenderer: regular, // TODO: follow material colors
          anchor: Anchor.topCenter,
          position: Vector2(size.x / 2, size.y / 2),
        );
      }
    }
    add(mapComponent!);
  }
}

final regular = TextPaint(
  style: TextStyle(
    fontSize: 24.0,
    color: BasicPalette.white.color,
  ),
);
