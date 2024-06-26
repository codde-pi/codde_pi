part of '../registry.dart';

class ClickButton extends WidgetComponent with HasCoddeProtocol {
  ClickButton(
      {required super.id,
      required super.class_,
      required super.properties,
      super.style,
      super.text,
      super.position,
      super.margin,
      super.size});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(
      ButtonComponent(
        button: CustomPainterComponent(
            size: size,
            painter: ClickButtonPainter(
                colorscheme: colorscheme, style: style, pressed: false)),
        buttonDown: CustomPainterComponent(
            size: size,
            painter: ClickButtonPainter(
                colorscheme: colorscheme, style: style, pressed: true)),
        onPressed: () => com.send(id, const WidgetRegistry.clickButton()),
        children: [textComponent],
      ),
    );
  }
}
