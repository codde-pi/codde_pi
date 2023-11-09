import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame/events.dart';
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
    print('long tap $name');
    com.send(name, true);
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
    com.send(name, false);
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
