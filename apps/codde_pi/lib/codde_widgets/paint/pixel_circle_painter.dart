import 'package:flutter/material.dart';

class PixelCirclePainter extends CustomPainter {
  final double radius;
  final double pixelSize;
  final double outlineWidth;
  final Color fillColor;

  PixelCirclePainter(
      {required this.radius,
      required this.pixelSize,
      required this.fillColor,
      required this.outlineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Calculate the center of the circle
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the pixelated outline of the circle
    for (double y = -radius; y <= radius; y += pixelSize) {
      for (double x = -radius; x <= radius; x += pixelSize) {
        double distSquared = x * x + y * y;
        double outerDistSquared =
            (radius - pixelSize / 2) * (radius - pixelSize / 2);
        double innerDistSquared =
            (radius - outlineWidth * pixelSize - pixelSize / 2) *
                (radius - outlineWidth * pixelSize - pixelSize / 2);

        if (distSquared <= outerDistSquared &&
            distSquared >= innerDistSquared) {
          final pixelRect =
              Rect.fromLTWH(center.dx + x, center.dy + y, pixelSize, pixelSize);
          canvas.drawRect(pixelRect, outlinePaint);
        }
      }
    }

    // Draw the filled pixelated circle
    for (double y = -radius + outlineWidth * pixelSize;
        y <= radius - outlineWidth * pixelSize;
        y += pixelSize) {
      for (double x = -radius + outlineWidth * pixelSize;
          x <= radius - outlineWidth * pixelSize;
          x += pixelSize) {
        if (x * x + y * y <=
            (radius - outlineWidth * pixelSize) *
                (radius - outlineWidth * pixelSize)) {
          final pixelRect =
              Rect.fromLTWH(center.dx + x, center.dy + y, pixelSize, pixelSize);
          canvas.drawRect(pixelRect, fillPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Return true to redraw when changes occur
  }
}
