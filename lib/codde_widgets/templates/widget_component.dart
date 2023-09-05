import 'dart:async';

import 'package:codde_pi/codde_widgets/templates/widget_painter.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

abstract class WidgetComponent extends CustomPainterComponent with HasGameRef {
  int id;
  ControllerClass class_;
  String? text;

  WidgetComponent({
    required this.id,
    required this.class_,
    this.text,
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
  FutureOr<void> onLoad() {
    super.onLoad();
    assert(gameRef.buildContext != null);
    painter ??= WidgetPainter(
        colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
        style: ControllerStyle.material);
    if (text != null) {
      final regular = TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(gameRef.buildContext!).textTheme.bodyMedium?.color);
      add(TextComponent(text: text, textRenderer: TextPaint(style: regular))
        ..anchor = Anchor.center
        ..x = size.x / 2 // size is a property from game
        ..y = size.y / 2);
    }
  }

  String get name => "${class_.name}_$id";
}
