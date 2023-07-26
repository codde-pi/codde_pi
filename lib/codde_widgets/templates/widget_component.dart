import 'dart:async';

import 'package:codde_pi/codde_widgets/templates/widget_painter.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class WidgetComponent extends CustomPainterComponent with HasGameRef {
  int id;
  ControllerClass class_;

  WidgetComponent({
    required this.id,
    required this.class_,
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
  }

  String get name => "$class_#$id";
}
