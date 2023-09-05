import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame/events.dart';

class ClickButton extends WidgetPlayer {
  ClickButton(
      {required super.id,
      required super.class_,
      super.position,
      super.painter,
      super.size});

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print('tap');
    com.send(this.name, null);
  }
}
