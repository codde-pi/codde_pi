part of '../registry.dart';
//useful

class PressButton extends WidgetComponent with HasCoddeProtocol {
  PressButton(
      {required super.id,
      required super.class_,
      super.style,
      super.text,
      super.margin,
      super.position,
      super.size,
      required super.properties});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(
      ButtonComponent(
        button: CustomPainterComponent(
            painter: PressButtonPainter(
                colorscheme: colorscheme, style: style, pressed: false)),
        buttonDown: CustomPainterComponent(
            painter: PressButtonPainter(
                colorscheme: colorscheme, style: style, pressed: true)),
        onPressed: () =>
            com.send(id, const WidgetRegistry.pressButton(pressed: true)),
        onReleased: () =>
            com.send(id, const WidgetRegistry.pressButton(pressed: false)),
        children: [textComponent],
      ),
    );
  }
}
