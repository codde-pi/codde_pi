part of '../registry.dart';

class ErrorPainter extends WidgetPainter {
  ErrorPainter({required super.colorscheme, required super.style});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = colorscheme.surface;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                size.width * 0.3269231, 0, size.width * 0.3461538, size.height),
            bottomRight: Radius.circular(size.width * 0.1153846),
            bottomLeft: Radius.circular(size.width * 0.1153846),
            topLeft: Radius.circular(size.width * 0.1153846),
            topRight: Radius.circular(size.width * 0.1153846)),
        paint_0_fill);
  }
}
