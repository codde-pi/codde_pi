part of '../registry.dart';

//Copy this CustomPainter code to the Bottom of the File
class PressButtonPainter extends WidgetPainter {
  PressButtonPainter({required super.colorscheme, super.pressed, super.style});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08416667;
    paint0Stroke.color = colorscheme.onSurface;
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawCircle(Offset(size.width * 0.5022084, size.height * 0.5022084),
        size.width * 0.4559393, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = colorscheme.surface;
    canvas.drawCircle(Offset(size.width * 0.5022084, size.height * 0.5022084),
        size.width * 0.4559393, paint0Fill);
  }
}
