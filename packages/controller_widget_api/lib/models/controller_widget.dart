import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'controller_background.dart';
import 'controller_class.dart';

part 'controller_widget.g.dart';

@JsonSerializable()
class ControllerWidget extends Equatable {
  final int id;
  final Offset position; // not toJson
  final ControllerClass? class_;
  final String? name;
  final ControllerBackground? background;
  final List<ControllerWidget> widgets;

  ControllerWidget(
      {required this.id,
      Offset? position,
      String? name,
      ControllerClass? class_,
      ControllerBackground? background,
      List<ControllerWidget>? widgets})
      : position = position ?? Offset(0, 0),
        name = name,
        class_ = class_,
        background = background,
        widgets = widgets ?? <ControllerWidget>[];

  @override
  List<Object?> get props => [id, position, name, class_, background, widgets];

  ControllerWidget copyWith(
      {int? id,
      Offset? position,
      String? name,
      ControllerClass? class_,
      ControllerBackground? background,
      List<ControllerWidget>? widgets}) {
    return ControllerWidget(
        id: id ?? this.id,
        position: position ?? this.position,
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
}
