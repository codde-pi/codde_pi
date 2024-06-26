part of '../registry.dart';

class DirectionalButtonArrowPainter extends WidgetPainter {
  DirectionalButtonValue direction;
  DirectionalButtonArrowPainter(
      {required this.direction,
      required super.colorscheme,
      super.pressed,
      super.style = ControllerStyle.material});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = colorscheme.onSurface;

    var origin = (0.0, 0.0);
    var peak =
        (size.width / 2, sqrt(pow(size.width, 2) + pow(size.width / 2, 2)));
    var end = (size.width, 0.0);
    var path = Path()
      ..moveTo(origin.$1, origin.$2)
      ..lineTo(peak.$1, peak.$2)
      ..lineTo(end.$1, end.$2)
      ..lineTo(origin.$1, origin.$2);
    canvas.save();
    final centerx = size.width / 2;
    final centery = size.width / 2;
    canvas.translate(centerx, centery);
    canvas.rotate((pi / 2) * rotation);
    canvas.translate(-centerx, -centery);
    canvas.drawPath(path, paint_0_fill);
    canvas.restore();
  }

  int get rotation {
    switch (direction) {
      case DirectionalButtonValue.up:
        return 2;
      case DirectionalButtonValue.right:
        return 3;
      case DirectionalButtonValue.down:
        return 0;
      case DirectionalButtonValue.left:
        return 1;
    }
  }
}
