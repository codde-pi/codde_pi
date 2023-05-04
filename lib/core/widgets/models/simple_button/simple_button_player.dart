part of 'simple_button.dart';

class SimpleButtonPlayer extends WidgetPlayer
    with TapCallbacks, HasSocketIOClient {
  SimpleButtonPlayer(
      {required super.id, super.position, super.painter, super.size});

  @override
  void onTapUp(TapUpEvent event) {
    print('tap');
    socket.emit('my_event', {'foo': 'bar $id'});
  }
}
