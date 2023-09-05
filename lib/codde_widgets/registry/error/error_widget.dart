import 'package:codde_pi/codde_widgets/registry/error/error_painter.dart';
import 'package:codde_pi/codde_widgets/templates/widget_component.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends WidgetComponent {
  ErrorWidget(this.subject, this.details)
      : super(id: 0, class_: ControllerClass.error);
  String subject;
  String details;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    assert(gameRef.buildContext != null);
    ThemeData theme = Theme.of(gameRef.buildContext!);
    painter = ErrorPainter(
        colorscheme: theme.colorScheme, style: ControllerStyle.material);
    final regular = TextStyle(color: theme.textTheme.bodyMedium?.color);
    final accent = TextStyle(color: theme.colorScheme.primary);
    add(TextComponent(text: subject, textRenderer: TextPaint(style: accent))
      ..anchor = Anchor.topLeft
      ..x = 0 // size is a property from game
      ..y = 0);
    add(TextComponent(text: details, textRenderer: TextPaint(style: regular))
      ..anchor = Anchor.center
      ..x = size.x / 2 // size is a property from game
      ..y = size.y / 2);
  }
}
