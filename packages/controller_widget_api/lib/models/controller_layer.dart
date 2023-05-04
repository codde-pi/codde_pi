import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller_layer.g.dart';

@JsonSerializable()
class ControllerLayer extends Equatable {
  final String id;
  final ControllerSize size; // not toJson
  final double y;
  final double x;
  final List<int> data;

  ControllerLayer(
      {String? id, ControllerSize? size, List<int>? data, double? x, double? y})
      : id = id ?? Uuid().v4(),
        size = size ?? ControllerSize(1920, 1080),
        x = x ?? 0,
        y = y ?? 0,
        data = data ?? [];

  @override
  List<Object?> get props => [id, size, data, x, y];

  ControllerLayer copyWith(
      {String? id,
      ControllerSize? size,
      List<ControllerBackground>? backgrounds,
      List<ControllerLayer>? widgets,
      List<int>? data,
      double? x,
      double? y}) {
    return ControllerLayer(
        id: id ?? this.id,
        size: size ?? this.size,
        x: x ?? this.x,
        y: y ?? this.y,
        data: data ?? this.data);
  }

  /// Deserializes the given [Map] into a [ControllerLayer].
  static ControllerLayer fromJson(Map<String, dynamic> json) =>
      _$ControllerLayerFromJson(json);

  /// Converts this [ControllerLayer] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerLayerToJson(this);
}
