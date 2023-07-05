part of 'simple_button.dart';

class SimpleButtonPlayer extends WidgetPlayer {
  SimpleButtonPlayer(
      {required super.id,
      super.position,
      super.svg,
      super.size,
      required super.pressedSvg});

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    print('tap');
    com.send('my_event', {'foo': 'bar $id'});
  }
}
