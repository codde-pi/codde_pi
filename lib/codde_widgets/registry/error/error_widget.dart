part of '../registry.dart';

// TODO: first widget listening to event
// Create event system in order to widget to listen to data
class ErrorWidget extends WidgetComponent {
  ErrorWidget(
      {
      // required this.subject,
      // required this.details,
      required super.id,
      required super.class_,
      super.position,
      super.margin,
      required super.properties});
  String? subject;
  String? details;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    assert(gameRef.buildContext != null);
    ThemeData theme = Theme.of(gameRef.buildContext!);
    final painter = ErrorPainter(
        colorscheme: theme.colorScheme, style: ControllerStyle.material);
    final regular = TextStyle(color: theme.textTheme.bodyMedium?.color);
    final accent = TextStyle(color: theme.colorScheme.primary);
    add(CustomPainterComponent(position: position, painter: painter, children: [
      TextComponent(text: subject, textRenderer: TextPaint(style: accent))
        ..anchor = Anchor.topLeft
        ..x = 0 // size is a property from game
        ..y = 0,
      TextComponent(text: details, textRenderer: TextPaint(style: regular))
        ..anchor = Anchor.center
        ..x = size.x / 2 // size is a property from game
        ..y = size.y / 2
    ]));
  }

  @override
  int get defaultSize =>
      2; // TODO: Or all device width ? -> use HudMarrgon component as parent of Custom Painter component
}
