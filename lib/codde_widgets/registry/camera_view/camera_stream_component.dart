part of '../registry.dart';

// TODO: separate URI Camera stream from CoddeProtocol driven camera stream
class CameraStreamComponent extends WidgetComponent with HasCoddeProtocol {
  String uri;
  CameraStreamComponent(
      {required super.class_,
      required super.id,
      super.margin,
      super.position,
      super.text,
      super.style,
      required super.properties})
      : assert(properties.getValue('uri') != null, "No URI provided"),
        uri = properties.getValue<String>(
            'uri')!; // FIXME:  Do an assert is really BAD, insteadprint Textcomponent indicating no URI is provided

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(MjpegStreamComponent.parseUri(uri: uri));
  }

  @override
  int get defaultSize => 0;

  @override
  Vector2 get computedSize => gameRef.size;
}
