import 'dart:async';

import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'directional_button_arrow.dart';
import 'directional_button_arrow_painter.dart';

class DirectionalButton extends WidgetPlayer {
  DirectionalButton(
      {required super.id,
      required super.class_,
      super.position,
      super.painter,
      super.size});
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(DirectionalButtonArrow(
        painter: DirectionalButtonArrowPainter(
            direction: DirectionalButtonValue.up,
            colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
            style: ControllerStyle.material),
        direction: DirectionalButtonValue.up,
        id: id,
        class_: class_,
        size: computedSize,
        position: computedPosition(DirectionalButtonValue.up)));
    add(DirectionalButtonArrow(
        painter: DirectionalButtonArrowPainter(
            direction: DirectionalButtonValue.right,
            colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
            style: ControllerStyle.material),
        direction: DirectionalButtonValue.right,
        id: id,
        class_: class_,
        size: computedSize,
        position: computedPosition(DirectionalButtonValue.right)));
    add(DirectionalButtonArrow(
        painter: DirectionalButtonArrowPainter(
            direction: DirectionalButtonValue.down,
            colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
            style: ControllerStyle.material),
        direction: DirectionalButtonValue.down,
        id: id,
        class_: class_,
        size: computedSize,
        position: computedPosition(DirectionalButtonValue.down)));
    add(DirectionalButtonArrow(
        painter: DirectionalButtonArrowPainter(
            direction: DirectionalButtonValue.left,
            colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
            style: ControllerStyle.material),
        direction: DirectionalButtonValue.left,
        id: id,
        class_: class_,
        size: computedSize,
        position: computedPosition(DirectionalButtonValue.left)));
  }

  Vector2 computedPosition(DirectionalButtonValue direction) {
    switch (direction) {
      case DirectionalButtonValue.up:
        return Vector2(childWidth * 2.5, childHeight * 0.5);
      case DirectionalButtonValue.right:
        return Vector2(childWidth * 3.5, childHeight * 2.5);
      case DirectionalButtonValue.down:
        return Vector2(childWidth * 2.5, childHeight * 3.5);
      case DirectionalButtonValue.left:
        return Vector2(childWidth * 0.5, childHeight * 2.5);
    }
  }

  Vector2 get computedSize => Vector2(childWidth, childHeight);
  double get childWidth => size.x / 4;
  double get childHeight => size.y / 4;
}

enum DirectionalButtonValue { up, down, left, right }
/* class DirectionalButtonValue {
  static const up = 1;
  static const right = 2;
  static const down = 3;
  static const left = 4;
  static const none = 0;
} */
