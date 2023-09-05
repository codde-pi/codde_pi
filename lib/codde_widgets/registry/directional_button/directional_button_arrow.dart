import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/registry/press_button/press_button.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:flame/src/events/messages/tap_up_event.dart';

import 'directional_button.dart';

class DirectionalButtonArrow extends WidgetPlayer {
  DirectionalButtonValue direction;
  DirectionalButtonArrow(
      {required this.direction,
      required super.id,
      required super.class_,
      super.position,
      super.painter,
      super.size});

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    com.send(name, packet);
  }

  /// Direction increment according to watch hands
  /// Null position <=> 0
  int get packet {
    switch (direction) {
      case DirectionalButtonValue.up:
        return 1;
      case DirectionalButtonValue.right:
        return 2;
      case DirectionalButtonValue.down:
        return 3;
      case DirectionalButtonValue.left:
        return 4;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    com.send(name, 0);
  }
}
