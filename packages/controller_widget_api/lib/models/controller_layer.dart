import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'controller_layer.g.dart';

/// TODO: unused dataclass

@JsonSerializable()
class ControllerLayer extends Equatable {
  final int id;
  final ControllerSize size;
  // final double? y;
  // final double? x;
  final List<int> data;
  final String? name;

  ControllerLayer(
      {required this.id, required this.size, required this.data, this.name});
  /*  : id = id ?? Uuid().v4(),
        size = size ?? ControllerSize(0, 40),
        x = x ?? 0,
        y = y ?? 0,
        data = data ?? []; */

  @override
  List<Object?> get props => [id, size, data, name];

  ControllerLayer copyWith(
      {int? id,
      ControllerSize? size,
      List<ControllerBackground>? backgrounds,
      List<ControllerLayer>? widgets,
      List<int>? data,
      String? name}) {
    return ControllerLayer(
        id: id ?? this.id,
        size: size ?? this.size,
        data: data ?? this.data,
        name: name ?? this.name);
  }

  /// Deserializes the given [Map] into a [ControllerLayer].
  static ControllerLayer fromJson(Map<String, dynamic> json) =>
      _$ControllerLayerFromJson(json);

  /// Converts this [ControllerLayer] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerLayerToJson(this);
}
