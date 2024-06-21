import 'package:codde_pi/theme.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class PixelButtonPainter extends CustomPainter {
  final String text;
  final double pixelSize;
  final bool pressed;
  final Color fillColor;
  final double outlineWidth;
  final bool shadow;

  double get padding => pixelSize / 2;

  // TODO: keep text or remove ?
  PixelButtonPainter(
      {this.text = '',
      required this.pixelSize,
      required this.outlineWidth,
      this.shadow = true,
      this.pressed = false,
      required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = pixelSize;

    final shadowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor.darken(.5);

    if (shadow) {
      // Draw shadow
      final shadowRect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawRect(shadowRect, shadowPaint);
      // Draw button background
      late final Rect buttonRect;
      if (pressed) {
        buttonRect = Rect.fromLTWH(0 + pixelSize, 0 + pixelSize,
            size.width - pixelSize, size.height - pixelSize);
      } else {
        buttonRect = Rect.fromLTWH(
            0, 0, size.width - pixelSize, size.height - pixelSize);
      }
      canvas.drawRect(buttonRect, paint);
    } else {
      // Draw background
      if (pressed) {
        final shadowRect = Rect.fromLTWH(0, 0, size.width, size.height);
        canvas.drawRect(shadowRect, shadowPaint);
      } else {
        final shadowRect = Rect.fromLTWH(0, 0, size.width, size.height);
        canvas.drawRect(shadowRect, paint);
      }
    }

    // Draw border (outline)
    canvas.drawLine(Offset(0, 0 - padding), Offset(size.width, 0 - padding),
        borderPaint); // Top
    canvas.drawLine(Offset(-padding, 0), Offset(-padding, size.height),
        borderPaint); // Left
    canvas.drawLine(Offset(size.width + padding, 0),
        Offset(size.width + padding, size.height), borderPaint); // Right
    canvas.drawLine(Offset(0, size.height + padding),
        Offset(size.width, size.height + padding), borderPaint); // Bottom

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: flameTextRenderer.style,
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2 - pixelSize / 2,
        (size.height - textPainter.height) / 2 - pixelSize / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Return true to redraw when changes occur
  }
}
