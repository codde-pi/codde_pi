part of 'simple_button.dart';

class SimpleButtonPlayer extends WidgetPlayer with TapCallbacks, HasCoddeCom {
  SimpleButtonPlayer(
      {required super.id, super.position, super.painter, super.size});

  @override
  void onTapUp(TapUpEvent event) {
    print('tap');
    com.send('my_event', {'foo': 'bar $id'});
  }
}
