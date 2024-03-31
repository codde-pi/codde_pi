part of '../registry.dart';

class Joystick extends WidgetComponent with HasCoddeProtocol {
  final double radius = 1;
  JoystickComponent? joystick;
  WidgetRegistry_Joystick lastData =
      const WidgetRegistry_Joystick(delta: Coord(x: 0, y: 0), intensity: 0);

  Joystick(
      {required super.id,
      required super.class_,
      super.style,
      super.text,
      super.margin,
      super.position,
      super.size,
      required super.properties});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    final joystick = JoystickComponent(
      knob: CircleComponent(
        scale: size, // TODO: replace by size
      ),
      background: CircleComponent(
        scale: size * 1.5, // TODO: replace by size
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
      knobRadius: radius,
    );
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick != null) {
      if (joystick!.direction != JoystickDirection.idle) {
        if (lastData.delta != toCoord(joystick!.delta) ||
            lastData.intensity != joystick!.intensity) {
          com.send(
              id,
              WidgetRegistry.joystick(
                  delta: toCoord(joystick!.relativeDelta),
                  intensity: joystick!.intensity));
          lastData = WidgetRegistry.joystick(
              delta: toCoord(joystick!.relativeDelta),
              intensity: joystick!.intensity) as WidgetRegistry_Joystick;
        }
      } else {
        com.send(
            id,
            WidgetRegistry.joystick(
                delta: toCoord(Vector2.zero()), intensity: 0));
      }
    }
  }

  @override
  int get defaultSize => 2;
}
