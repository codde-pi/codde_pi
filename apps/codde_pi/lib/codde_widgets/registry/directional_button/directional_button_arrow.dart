part of '../registry.dart';

class DirectionalButtonArrow extends PositionComponent with HasCoddeProtocol {
  DirectionalButtonValue direction;
  DirectionalButtonArrowPainter painter;
  int id;
  ControllerStyle style;
  DirectionalButtonArrow({
    required this.direction,
    required this.id,
    required this.painter,
    required this.style,
    super.position,
    super.size,
  });

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(
      ButtonComponent(
          button: CustomPainterComponent(
            size: size,
            painter: painter..pressed = false,
          ),
          buttonDown: CustomPainterComponent(
            size: size,
            painter: painter..pressed = true,
          ),
          onPressed: () =>
              com.send(id, WidgetRegistry.directionalButton(direction: packet)),
          onReleased: () => com.send(
              id, WidgetRegistry.directionalButton(direction: packet))),
    );
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
}
