import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'controller_widget.freezed.dart';
part 'controller_widget.g.dart';

@freezed
class ControllerWidget with _$ControllerWidget {
  /* final int id;
  final int x;
  final int y;
  final ControllerClass? class_;
  final String? nickname;
  final ControllerBackground? background;
  final List<ControllerWidget> widgets;
  final ControllerProperties properties; */

  const ControllerWidget._();
  const factory ControllerWidget(
          {required int id,
          @Default(0) int x,
          @Default(0) int y,
          String? nickname,
          ControllerClass? class_,
          ControllerBackground? background,
          ControllerProperties? properties,
          String? text,
          @Default(<ControllerWidget>[]) List<ControllerWidget> widgets}) =
      _ControllerWidget;

  @override
  // List<Object?> get props => [id, x, y, nickname, class_, background, widgets];
  String get name => "${class_}_$id";

  /// Deserializes the given [Map] into a [ControllerWidget].
  factory ControllerWidget.fromJson(Map<String, dynamic> json) =>
      _$ControllerWidgetFromJson(json);

  XmlElement toXml() {
    final Iterable<XmlAttribute> attributes = toJson()
        .entries
        .map<XmlAttribute?>(
          (e) {
            /* else if (e.key == 'position') {
              (e.value as Map<String, dynamic>).forEach(
                  (key, value) => XmlAttribute(XmlName(key), value.toString()));
            } */
            if (e.key != 'background' && e.key != 'widgets') {
              return XmlAttribute(
                  XmlName(e.key.replaceAll('_', '')), e.value.toString());
            }
          },
        )
        .where((element) => element != null)
        .cast<XmlAttribute>();
    return XmlElement(
        XmlName('objectgroup'), attributes, widgets.map((e) => e.toXml()));
  }
}
