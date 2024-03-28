part of '../../codde_widgets.dart';

const SCALE_FACTOR = 100.0;

abstract class WidgetComponent extends HudMarginComponent
    with HasGameRef, HasMaterial {
  int id;
  ControllerClass class_;
  String? text;
  ControllerStyle style;
  ControllerProperties properties;
  String nickyName;

  int get defaultSize;

  WidgetComponent({
    required this.id,
    required this.class_,
    required this.properties,
    this.style = ControllerStyle.material,
    this.text,
    super.margin,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor = Anchor.center,
    super.children,
    super.priority,
    this.nickyName = '',
  });

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size = computedSize;
    // TODO: disabled prop
  }

  Vector2 get computedSize =>
      Vector2.all((properties.size ?? defaultSize) * SCALE_FACTOR);

  // String get name => "$id_${class_.name}";

  TextComponent get textComponent {
    final regular = TextStyle(
        fontWeight: FontWeight.w700,
        color: Theme.of(gameRef.buildContext!).textTheme.bodyMedium?.color);
    return TextComponent(text: text, textRenderer: TextPaint(style: regular))
      ..anchor = Anchor.center
      ..x = size.x / 2 // size is a property from game
      ..y = size.y / 2;
  }
}
