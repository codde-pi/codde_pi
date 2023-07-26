import 'package:codde_pi/codde_widgets/templates/widget_component.dart';
import 'package:codde_pi/codde_widgets/templates/widget_painter.dart';
import 'package:flame/events.dart';
import 'package:flame_coddecom/flame_coddecom.dart';

class WidgetPlayer extends WidgetComponent with TapCallbacks, HasCoddeCom {
  WidgetPlayer({
    required super.id,
    required super.class_,
    super.painter,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  @override
  void onTapDown(TapDownEvent event) {
    (painter as WidgetPainter).pressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    (painter as WidgetPainter).pressed = false;
  }

  // TODO: check if painter.pressed modification and shouldRepaint method are sufficients
  /* @override
  void render(Canvas canvas) {
    if (_pressed) {
      svg!.render(canvas, size);
    } else {
      pressedSvg.render(canvas, size);
    }
  } */
}
