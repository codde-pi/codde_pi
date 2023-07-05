import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_coddecom/flame_coddecom.dart';
import 'package:flame_svg/flame_svg.dart';

class WidgetPlayer extends SvgComponent with TapCallbacks, HasCoddeCom {
  int id;
  Svg pressedSvg;
  bool _pressed = false;

  WidgetPlayer(
      {required this.id,
      super.svg,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.children,
      super.priority,
      required this.pressedSvg});

  /* void _drawSprite(Canvas canvas, Svg svg, double relativeX, double relativeY) {
    svg.render(
      canvas,
      position: Vector2(relativeX * size.x, relativeY * size.y),
      anchor: Anchor.center,
    );
  } */

  @override
  void onTapDown(TapDownEvent event) {
    _pressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    _pressed = false;
  }

  @override
  void render(Canvas canvas) {
    if (_pressed) {
      svg!.render(canvas, size);
    } else {
      pressedSvg.render(canvas, size);
    }
  }
}
