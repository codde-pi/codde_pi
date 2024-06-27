part of '../../codde_widgets.dart';

abstract class WidgetComponent extends HudMarginComponent
    with HasGameRef, HasMaterial {
  int id;
  ControllerClass class_;
  String? text;
  ControllerStyle style;
  ControllerProperties properties;
  String nickyName;
  double sizeFactor = 1.0;

  WidgetComponent({
    required this.id,
    required this.class_,
    required this.properties,
    this.style = ControllerStyle.material,
    this.text,
    // super.size,
    Vector2? size,
    super.margin,
    super.position,
    super.angle,
    super.anchor = Anchor.topLeft,
    super.children,
    super.priority,
    this.nickyName = '',
  }) : super(size: size ?? Vector2.all(100.0));
  /* })  : sizeFactor = sizeFactor ?? 1.0,
        super(size: (size ?? Vector2.all(100.0)) * (sizeFactor ?? 1.0)); */

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size = size * sizeFactor;

    // TODO: disabled prop
  }

  // String get name => "$id_${class_.name}";

  TextComponent get textComponent {
    return TextComponent(
        size: size, text: text, textRenderer: flameTextRendererBlack)
      ..anchor = Anchor.center
      ..x = size.x / 2 // size is a property from game
      ..y = size.y / 2;
  }
}
