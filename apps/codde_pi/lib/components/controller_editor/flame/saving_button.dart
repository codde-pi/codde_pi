import 'dart:async';

import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class SavingButton extends PositionComponent {
  final Function() onPressed;
  SavingButton({required this.onPressed});

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load("icons/save.png");
    add(HudButtonComponent(
        anchor: Anchor.topRight,
        size: Vector2.all(50.0),
        margin: const EdgeInsets.only(right: widgetGutter, top: widgetGutter),
        onPressed: onPressed,
        button: SpriteComponent(
            size: Vector2.all(50.0),
            anchor: Anchor.center,
            sprite: sprite,
            paint: Paint()..color = Colors.red),
        buttonDown: SpriteComponent(anchor: Anchor.center, sprite: sprite)));

    return super.onLoad();
  }
}
