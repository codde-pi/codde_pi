import 'package:flame/components.dart';

class WidgetPlayer extends CustomPainterComponent {
  int id;
  WidgetPlayer({
    required this.id,
    super.painter,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });
}
