part of '../../codde_widgets.dart';

abstract class WidgetPainter extends CustomPainter {
  ColorScheme colorscheme;
  ControllerStyle style;
  bool pressed;

  WidgetPainter(
      {required this.colorscheme, this.pressed = false, ControllerStyle? style})
      : style = style ?? ControllerStyle.material;

  @override
  void paint(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant WidgetPainter oldDelegate) {
    return oldDelegate.colorscheme != colorscheme || oldDelegate.style != style;
  }
}
