import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';

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
            Rect.fromLTWH(
                size.width * 0.3269231, 0, size.width * 0.3461538, size.height),
            bottomRight: Radius.circular(size.width * 0.1153846),
            bottomLeft: Radius.circular(size.width * 0.1153846),
            topLeft: Radius.circular(size.width * 0.1153846),
            topRight: Radius.circular(size.width * 0.1153846)),
        paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = colorscheme.surface;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * -0.6730769, 0, size.width * 0.3461538,
                size.height),
            bottomRight: Radius.circular(size.width * 0.1153846),
            bottomLeft: Radius.circular(size.width * 0.1153846),
            topLeft: Radius.circular(size.width * 0.1153846),
            topRight: Radius.circular(size.width * 0.1153846)),
        paint_1_fill);
  }
}
