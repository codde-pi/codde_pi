part of '../registry.dart';

class DirectionalButtonArrow extends WidgetComponent with HasCoddeProtocol {
  DirectionalButtonValue direction;
  DirectionalButtonArrowPainter painter;
  DirectionalButtonArrow(
      {required this.direction,
      required super.id,
      required super.class_,
      required this.painter,
      super.style,
      super.position,
      super.margin,
      super.size,
      super.properties = ControllerProperties.empty});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(
      ButtonComponent(
          button: CustomPainterComponent(
            painter: painter..pressed = false,
          ),
          buttonDown: CustomPainterComponent(
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

  @override
  int get defaultSize => 1;
}
