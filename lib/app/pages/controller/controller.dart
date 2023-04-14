import 'package:codde_pi/app/pages/controller/painted_component.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart' hide Animation, Image;

// TODO: implement `EditController` and `PlayController`
class ControllerDraft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: TiledGame());
  }
}

class TiledGame extends FlameGame {
  late TiledComponent mapComponent;

  double time = 0;
  Vector2 cameraTarget = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(mapComponent);

    // final objGroup =
    // mapComponent.tileMap.getLayer<ObjectGroup>('AnimatedCoins');
    final layers = mapComponent.tileMap.renderableLayers;
    final coins = await Flame.images.load('coins.png');
    final sprite = await Sprite.load('coins.png');

    camera.zoom = 0;
    // camera.viewport = FixedResolutionViewport(Vector2(16 * 28, 16 * 14));

    // We are 100% sure that an object layer named `AnimatedCoins`
    // exists in the example `map.tmx`.
    for (final obj in layers) {
      final parent = PositionComponent(
        position: Vector2(0, 0),
        size: Vector2(100, 100),
        anchor: Anchor.topLeft,
      );
      final child = Player(
        painter: obj.layer.class_ == "simple_button"
            ? PlayerCustomPainter()
            : PlayerCustomPainter2(),
        size: Vector2.all(100),
        position: obj.layer.class_ == "simple_button"
            ? Vector2(obj.layer.x.toDouble(), obj.layer.y.toDouble())
            : Vector2(20, 20),
      );
      await parent.add(child);
      add(parent);
    }
  }

  /* @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    final tiledMap = mapComponent.tileMap.map;
    // Pan the camera down and right for 10 seconds, then reverse
    if (time % 20 < 10) {
      cameraTarget.x = tiledMap.width * tiledMap.tileWidth.toDouble() -
          camera.viewport.effectiveSize.x;
      cameraTarget.y = camera.viewport.effectiveSize.y;
    } else {
      cameraTarget.setZero();
    }
    camera.moveTo(cameraTarget);
  } */
}
