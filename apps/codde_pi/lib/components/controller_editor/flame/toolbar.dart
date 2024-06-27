import 'dart:async';

import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flame/game.dart';

import 'controller_editor_game.dart';

const double defaultOffset = 32.0;
const double defaultIconSize = 32.0;

class ToolBar extends ValueRoute<int>
    with HasGameReference<ControllerEditorGame> {
  ToolBar({required this.widgetName}) : super(value: -1, transparent: true);
  String widgetName;
// String props;
  Vector2 defaultButtonSize = Vector2.all(defaultOffset);
  String assetPath = "icons";
  late final iconSettings = "$assetPath/settings.png";
  late final iconTrash = "$assetPath/trash.webp";

  Vector2 buttonPosition(index, {double offset = defaultOffset}) {
    return Vector2(index * offset, 0);
  }

  Future<SpriteComponent> _buttonComponent(bool down, String iconPath) async {
    final sprite = await Sprite.load(iconPath);
    return SpriteComponent(
        sprite: sprite,
        size: Vector2.all(defaultIconSize),
        paint: down ? flameButtonDownPaint : flameButtonPaint);
  }

  TextComponent _textButtonComponent(bool down, String text) {
    return TextComponent(
        size: defaultButtonSize, text: text, textRenderer: flameTextRenderer);
  }

  Component _divider(int index) => RectangleComponent(
      size: Vector2(1, 1),
      position: buttonPosition(index, offset: 1),
      paint: Paint()..color = BasicPalette.white.color);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
  }

  @override
  Component build() {
    final size = Vector2(250, 130);
    const radius = 18.0;
    final starGap = (size.x - 5 * 2 * radius) / 6;
    return DialogBackground(
      position: game.size / 2,
      size: size,
      children: [
        /* // Setings
        ButtonComponent(
        size: defaultButtonSize,
        position: buttonPosition(0),
        buttonDown: await _buttonComponent(true, iconSettings),
        button: await _buttonComponent(false, iconSettings)),
    _divider(1),
    // API
    ButtonComponent(
        size: defaultButtonSize,
        position: buttonPosition(2),
        buttonDown: _textButtonComponent(true, "DOC"),
        button: _textButtonComponent(false, "DOC")),
    _divider(3),
    // DOC
    ButtonComponent(
        size: defaultButtonSize,
        position: buttonPosition(4),
        buttonDown: _textButtonComponent(true, "API"),
        button: _textButtonComponent(false, "API")),
    _divider(5),
    // Trash
    ButtonComponent(
        size: defaultButtonSize,
        position: buttonPosition(6),
        buttonDown: await _buttonComponent(true, iconTrash),
        button: await _buttonComponent(false, iconTrash)),
    _divider(7) */
      ],
    );
  }
}

class DialogBackground extends RectangleComponent with TapCallbacks {
  DialogBackground({super.position, super.size, super.children})
      : super(
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xee858585),
        );
}
