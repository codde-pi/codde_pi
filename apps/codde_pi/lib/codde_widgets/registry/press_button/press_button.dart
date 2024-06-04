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
          size: size,
          painter: PixelButtonPainter(
              outlineWidth: cOutlineWidth,
              text: "Normal",
              pixelSize: 7.0,
              fillColor: colorscheme.onSurface),
        ) /*PixelCirclePainter(
                radius: size.x,
                outlineWidth: 2.0,
                pixelSize:
                    7.0)) */ /* PressButtonPainter(
                colorscheme: colorscheme, style: style, pressed: false)) */
        ,
        buttonDown: CustomPainterComponent(
            size: size,
            painter: PixelButtonPainter(
                outlineWidth: cOutlineWidth,
                pixelSize: cPixelSize,
                fillColor: colorscheme.onSurface)),
        onPressed: () =>
            com.send(id, const WidgetRegistry.pressButton(pressed: true)),
        onReleased: () =>
            com.send(id, const WidgetRegistry.pressButton(pressed: false)),
        children: [textComponent],
      ),
    );
  }
}
