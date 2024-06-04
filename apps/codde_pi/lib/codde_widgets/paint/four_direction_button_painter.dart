import 'package:flutter/material.dart';

class FourDirectionButtonPainter extends CustomPainter {
  final double pixelSize;
  final bool pressedUp;
  final bool pressedDown;
  final bool pressedLeft;
  final bool pressedRight;

  FourDirectionButtonPainter({
    required this.pixelSize,
    this.pressedUp = false,
    this.pressedDown = false,
    this.pressedLeft = false,
    this.pressedRight = false,
  });

  double get padding => pixelSize / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = pixelSize;

    final shadowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[700]!;

    final arrowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    // Helper function to draw each button direction
    void drawButton(Rect rect, bool pressed, List<Offset> arrowOffsets) {
      // Draw shadow
      final shadowRect = rect.translate(padding, padding);
      canvas.drawRect(shadowRect, shadowPaint);

      // Draw button background
      final buttonRect = pressed ? rect.translate(padding, padding) : rect;
      canvas.drawRect(buttonRect, paint);

      // Draw border (outline)
      canvas.drawLine(
          buttonRect.topLeft, buttonRect.topRight, borderPaint); // Top
      canvas.drawLine(
          buttonRect.topLeft, buttonRect.bottomLeft, borderPaint); // Left
      canvas.drawLine(
          buttonRect.topRight, buttonRect.bottomRight, borderPaint); // Right
      canvas.drawLine(
          buttonRect.bottomLeft, buttonRect.bottomRight, borderPaint); // Bottom

      // Draw pixelated arrow
      final arrowOffset = pressed ? Offset(padding, padding) : Offset.zero;
      for (final offset in arrowOffsets) {
        final pixelRect = Rect.fromLTWH(
          buttonRect.center.dx + offset.dx + arrowOffset.dx - pixelSize / 2,
          buttonRect.center.dy + offset.dy + arrowOffset.dy - pixelSize / 2,
          pixelSize,
          pixelSize,
        );
        canvas.drawRect(pixelRect, arrowPaint);
      }
    }

    // Define the size and position of each directional button
    final buttonSize = size.width / 3;

    final upRect = Rect.fromLTWH(buttonSize, 0, buttonSize, buttonSize);
    final downRect =
        Rect.fromLTWH(buttonSize, 2 * buttonSize, buttonSize, buttonSize);
    final leftRect = Rect.fromLTWH(0, buttonSize, buttonSize, buttonSize);
    final rightRect =
        Rect.fromLTWH(2 * buttonSize, buttonSize, buttonSize, buttonSize);

    // Define the pixelated arrow offsets
    final upArrowOffsets = [
      Offset(0, -2 * pixelSize),
      Offset(0, -pixelSize),
      Offset(-pixelSize, 0),
      Offset(pixelSize, 0),
    ];

    final downArrowOffsets = [
      Offset(0, 2 * pixelSize),
      Offset(0, pixelSize),
      Offset(-pixelSize, 0),
      Offset(pixelSize, 0),
    ];

    final leftArrowOffsets = [
      Offset(-2 * pixelSize, 0),
      Offset(-pixelSize, 0),
      Offset(0, -pixelSize),
      Offset(0, pixelSize),
    ];

    final rightArrowOffsets = [
      Offset(2 * pixelSize, 0),
      Offset(pixelSize, 0),
      Offset(0, -pixelSize),
      Offset(0, pixelSize),
    ];

    // Draw each directional button
    drawButton(upRect, pressedUp, upArrowOffsets);
    drawButton(downRect, pressedDown, downArrowOffsets);
    drawButton(leftRect, pressedLeft, leftArrowOffsets);
    drawButton(rightRect, pressedRight, rightArrowOffsets);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Return true to redraw when changes occur
  }
}
