part of 'simple_button.dart';

class SimpleButtonPainter extends CustomPainter {
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
