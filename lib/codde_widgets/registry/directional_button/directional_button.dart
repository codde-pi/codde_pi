part of '../registry.dart';

class DirectionalButton extends WidgetComponent {
  @override
  double get sizeFactor => 2.0;
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
          size: size,
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
                style: style,
                size: childComputedSize,
                position: computedPosition(DirectionalButtonValue.up)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.right,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.right,
                id: id,
                style: style,
                size: childComputedSize,
                position: computedPosition(DirectionalButtonValue.right)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.down,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.down,
                id: id,
                style: style,
                size: childComputedSize,
                position: computedPosition(DirectionalButtonValue.down)),
            DirectionalButtonArrow(
                painter: DirectionalButtonArrowPainter(
                    direction: DirectionalButtonValue.left,
                    colorscheme: Theme.of(gameRef.buildContext!).colorScheme,
                    style: ControllerStyle.material),
                direction: DirectionalButtonValue.left,
                id: id,
                style: style,
                size: childComputedSize,
                position: computedPosition(DirectionalButtonValue.left))
          ]),
    );
  }

  Vector2 computedPosition(DirectionalButtonValue direction) {
    switch (direction) {
      case DirectionalButtonValue.up:
        return Vector2(childWidth * 1.5, childHeight * 0.25);
      case DirectionalButtonValue.right:
        return Vector2(childWidth * 2.75, childHeight * 1.5);
      case DirectionalButtonValue.down:
        return Vector2(childWidth * 1.5, childHeight * 2.75);
      case DirectionalButtonValue.left:
        return Vector2(childWidth * 0.25, childHeight * 1.5);
    }
  }

  Vector2 get childComputedSize => Vector2(childWidth, childHeight);
  double get childWidth => size.x / 4;
  double get childHeight => size.y / 4;
}

enum DirectionalButtonValue { up, down, left, right }
/* class DirectionalButtonValue {
  static const up = 1;
  static const right = 2;
  static const down = 3;
  static const left = 4;
  static const none = 0;
} */
