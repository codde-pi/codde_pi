import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame/events.dart';

class SimpleButtonPlayer extends WidgetPlayer {
  SimpleButtonPlayer(
      {required super.id,
      required super.class_,
      super.position,
      super.painter,
      super.size});

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    print('tap');
    com.send('my_event', {'foo': 'bar $id'});
  }
}
