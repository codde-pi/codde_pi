import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'controller_background.dart';

part 'controller_layer.g.dart';

@JsonSerializable()
class ControllerLayer extends Equatable {
  final String uid;
  final Size size; // not toJson
  final double y;
  final double x;
  final List<int> data;

  ControllerLayer(
      {String? uid, Size? size, List<int>? data, double? x, double? y})
      : uid = uid ?? Uuid().v4(),
        size = size ?? Size(1920, 1080),
        x = x ?? 0,
        y = y ?? 0,
        data = data ?? [];

  @override
  List<Object?> get props => [uid, size, data, x, y];

  ControllerLayer copyWith(
      {String? uid,
      Size? size,
      List<ControllerBackground>? backgrounds,
      List<ControllerLayer>? widgets,
      List<int>? data,
      double? x,
      double? y}) {
    return ControllerLayer(
        uid: uid ?? this.uid,
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
