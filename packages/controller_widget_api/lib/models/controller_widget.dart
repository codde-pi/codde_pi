import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

part 'controller_widget.g.dart';

@JsonSerializable()
class ControllerWidget extends Equatable {
  final int id;
  final int x;
  final int y;
  final ControllerClass? class_;
  final String? name;
  final ControllerBackground? background;
  final List<ControllerWidget> widgets;

  ControllerWidget(
      {required this.id,
      int? x,
      int? y,
      String? name,
      ControllerClass? class_,
      ControllerBackground? background,
      List<ControllerWidget>? widgets})
      : x = x ?? 0,
        y = y ?? 0,
        name = name,
        class_ = class_,
        background = background,
        widgets = widgets ?? <ControllerWidget>[];

  @override
  List<Object?> get props => [id, x, y, name, class_, background, widgets];

  ControllerWidget copyWith(
      {int? id,
      int? x,
      int? y,
      String? name,
      ControllerClass? class_,
      ControllerBackground? background,
      List<ControllerWidget>? widgets}) {
    return ControllerWidget(
        id: id ?? this.id,
        x: x ?? this.x,
        y: y ?? this.y,
        background: background ?? this.background,
        widgets: widgets ?? this.widgets,
        name: name ?? this.name,
        class_: class_ ?? this.class_);
  }

  /// Deserializes the given [JsonMap] into a [ControllerWidget].
  static ControllerWidget fromJson(Map<String, dynamic> json) =>
      _$ControllerWidgetFromJson(json);

  /// Converts this [ControllerWidget] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerWidgetToJson(this);

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
