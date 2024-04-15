part of '../registry.dart';

const double CORNER = 0.1153846;
const double FIRST_POS = 0.3269231;
const double THIRD_PARTY = 0.3461538;

class DirectionalButtonPainter extends WidgetPainter {
  DirectionalButtonPainter(
      {required super.colorscheme,
      super.pressed,
      super.style = ControllerStyle.material});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = colorscheme.surface;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * FIRST_POS, 0, size.width * THIRD_PARTY,
                size.height),
            bottomRight: Radius.circular(size.width * CORNER),
            bottomLeft: Radius.circular(size.width * CORNER),
            topLeft: Radius.circular(size.width * CORNER),
            topRight: Radius.circular(size.width * CORNER)),
        paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = colorscheme.surface;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            // 0.6730769
            Rect.fromLTWH(0, size.height * FIRST_POS, size.width,
                size.height * THIRD_PARTY),
            bottomRight: Radius.circular(size.width * CORNER),
            bottomLeft: Radius.circular(size.width * CORNER),
            topLeft: Radius.circular(size.width * CORNER),
            topRight: Radius.circular(size.width * CORNER)),
        paint_1_fill);
  }
}
