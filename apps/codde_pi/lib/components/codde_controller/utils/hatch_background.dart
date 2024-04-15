import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class HatchBackground extends CustomPainter {
  ColorScheme colorscheme;
  HatchBackground({required this.colorscheme});
  @override
  void paint(Canvas canvas, Size size) {
    // Prepare a rectangle shape to draw the pattern on.
    const rect = Rect.fromLTWH(0, 0, 2500, 2500);

    // Create a Pattern object of diagonal stripes with the colors we want.
    Pattern pattern = Pattern.fromValues(
        patternType: PatternType.subtlepatch,
        bgColor: colorscheme.background.darken(0.3),
        fgColor: colorscheme.onBackground.darken(0.3),
        featuresCount: 100);

    // Paint the pattern on the rectangle.
    pattern.paintOnRect(canvas, size, rect);
  }

  @override
  bool shouldRepaint(covariant HatchBackground oldDelegate) {
    return oldDelegate.colorscheme != colorscheme;
  }
}
