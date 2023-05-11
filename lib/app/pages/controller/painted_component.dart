import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

/* class CustomPainterExample extends FlameGame with TapDetector {
  static const description = '''
    Example demonstration of how to use the CustomPainterComponent.
    On the screen you can see a component using a custom painter being
    rendered on a FlameGame, and if you tap, that same painter is used to
    show a smiley on a widget overlay.
  ''';

  @override
  Future<void> onLoad() async {
    add(Player());
  }

  @override
  void onTap() {
    if (overlays.isActive('Smiley')) {
      overlays.remove('Smiley');
    } else {
      overlays.add('Smiley');
    }
  }
} */

class PlayerCustomPainter extends CustomPainter {
  late final facePaint = Paint()..color = Colors.yellow;

  late final eyesPaint = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final faceRadius = size.height / 2;

    canvas.drawCircle(
      Offset(
        faceRadius,
        faceRadius,
      ),
      faceRadius,
      facePaint,
    );

    final eyeSize = faceRadius * 0.15;

    canvas.drawCircle(
      Offset(
        faceRadius - (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );

    canvas.drawCircle(
      Offset(
        faceRadius + (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PlayerCustomPainter2 extends CustomPainter {
  late final facePaint = Paint()..color = Colors.red;

  late final eyesPaint = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final faceRadius = size.height / 2;

    canvas.drawCircle(
      Offset(
        faceRadius,
        faceRadius,
      ),
      faceRadius,
      facePaint,
    );

    final eyeSize = faceRadius * 0.15;

    canvas.drawCircle(
      Offset(
        faceRadius - (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );

    canvas.drawCircle(
      Offset(
        faceRadius + (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Player extends CustomPainterComponent with HasGameRef, TapCallbacks {
  Player(
      {required CustomPainter painter,
      required Vector2 size,
      required Vector2 position})
      : super(size: size, painter: painter, position: position);

  @override
  void onTapUp(TapUpEvent event) {
    // Do something in response to a tap
    if (this.painter.runtimeType == PlayerCustomPainter) {
      print('Simple_button !');
    } else {
      print('Joystick !!');
    }
  }

  /* @override
  void update(double dt) {
    super.update(dt);

    x += speed * direction * dt;

    if ((x + width >= gameRef.size.x && direction > 0) ||
        (x <= 0 && direction < 0)) {
      direction *= -1;
    }
  } */
}
