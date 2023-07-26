import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';

class WidgetPainter extends CustomPainter {
  ColorScheme colorscheme;
  bool pressed;
  ControllerStyle style;

  WidgetPainter(
      {required this.colorscheme, this.pressed = false, required this.style});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant WidgetPainter oldDelegate) {
    return oldDelegate.colorscheme != colorscheme ||
        oldDelegate.pressed != pressed;
  }
}
