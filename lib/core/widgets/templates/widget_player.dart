import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_svg/flame_svg.dart';

class WidgetPlayer extends SvgComponent {
  int id;
  WidgetPlayer({
    required this.id,
    super.svg,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  void _drawSprite(
      Canvas canvas, Sprite sprite, double relativeX, double relativeY) {
    // TODO: fgetWigetSprite(pressed: true)
    sprite.render(
      canvas,
      position: Vector2(relativeX * size.x, relativeY * size.y),
      anchor: Anchor.center,
    );
  }
}
