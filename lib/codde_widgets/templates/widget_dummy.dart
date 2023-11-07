import 'widget_component.dart';

/// Dummy implementation of [WidgetComponent],
/// providing widget painting without any interaction
class WidgetDummy extends WidgetComponent {
  WidgetDummy({
    required super.id,
    required super.class_,
    super.text,
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
