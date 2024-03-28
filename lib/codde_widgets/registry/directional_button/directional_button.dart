part of '../registry.dart';

class DirectionalButton extends WidgetComponent {
  DirectionalButton(
      {required super.id,
      required super.class_,
      super.text,
      super.position,
      super.margin,
      super.style,
      super.size,
      required super.properties});
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(
      CustomPainterComponent(
          painter: DirectionalButtonPainter(
            colorscheme: colorscheme,
            style: style,
          ),
          children: [
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.up,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.up,
                id: id,
                class_: class_,
                size: computedSize,
                position: computedPosition(DirectionalButtonValue.up)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.right,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.right,
                id: id,
                class_: class_,
                size: computedSize,
                position: computedPosition(DirectionalButtonValue.right)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.down,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.down,
                id: id,
                class_: class_,
                size: computedSize,
                position: computedPosition(DirectionalButtonValue.down)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.left,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.left,
                id: id,
                class_: class_,
                size: computedSize,
                position: computedPosition(DirectionalButtonValue.left))
          ]),
    );
  }

  Vector2 computedPosition(DirectionalButtonValue direction) {
    switch (direction) {
      case DirectionalButtonValue.up:
        return Vector2(childWidth * 2.5, childHeight * 0.5);
      case DirectionalButtonValue.right:
        return Vector2(childWidth * 3.5, childHeight * 2.5);
      case DirectionalButtonValue.down:
        return Vector2(childWidth * 2.5, childHeight * 3.5);
      case DirectionalButtonValue.left:
        return Vector2(childWidth * 0.5, childHeight * 2.5);
    }
  }

  Vector2 get computedSize => Vector2(childWidth, childHeight);
  double get childWidth => size.x / 4;
  double get childHeight => size.y / 4;

  @override
  int get defaultSize => 4; // TODO: 4 or 2 ?
}

enum DirectionalButtonValue { up, down, left, right }
/* class DirectionalButtonValue {
  static const up = 1;
  static const right = 2;
  static const down = 3;
  static const left = 4;
  static const none = 0;
} */
