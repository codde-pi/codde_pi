part of '../../codde_widgets.dart';

/// Dummy implementation of [WidgetComponent],
/// providing widget painting without any interaction
class WidgetDummy extends HudMarginComponent {
  int id;
  ControllerClass class_;

  WidgetDummy(
      {required this.id,
      required this.class_,
      super.position,
      super.margin,
      super.size,
      super.children});
  // TODO: find image based on class name and add [SpriteComponent]
}
