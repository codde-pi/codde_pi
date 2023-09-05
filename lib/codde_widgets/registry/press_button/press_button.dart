import 'dart:async';

import 'dart:ui';

import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/cache/assets_cache.dart';
import 'package:flame/src/cache/images.dart';
import 'package:flame/src/game/game_render_box.dart';
import 'package:flame/src/game/game_widget/gesture_detector_builder.dart';
import 'package:flame/src/game/overlay_manager.dart';
import 'package:flame/src/game/projector.dart';
import 'package:flame/src/sprite.dart';
import 'package:flame/src/sprite_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/rendering/object.dart';
import 'package:flutter/src/services/mouse_cursor.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vector_math/vector_math_64.dart';
//useful

class PressButton extends WidgetPlayer {
  PressButton(
      {required super.id,
      required super.class_,
      super.position,
      super.painter,
      super.text,
      super.size});

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    print('long tap ${this.name}');
    com.send(this.name, true);
  }

  /* @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print('tap ${this.name}');
    com.send(this.name, true);
  } */

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    print('release');
    com.send(this.name, false);
  }
}

/* mixin GestureCallbacks on Component {
  void onLongPress() {}
  void onLongPressUp() {}

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();
    final game = findGame()! as FlameGame;
    if (game.firstChild<>() == null) {
      game.add(MultiTapDispatcher());
    }
  }} */
