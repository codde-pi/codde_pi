import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller_map.g.dart';

@JsonSerializable()
class ControllerMap extends Equatable {
  final String uid;
  final ControllerSize size;
  final String path;
  final ControllerLayer? layer;
  final List<ControllerBackground> backgrounds;
  final List<ControllerWidget> widgets;
  final int nextLayerId;
  final int nextObjectId;

  ControllerMap(
      {required this.path,
      this.layer,
      String? uid,
      ControllerSize? size,
      List<ControllerBackground>? backgrounds,
      List<ControllerWidget>? widgets,
      int? nextLayerId,
      int? nextObjectId})
      : uid = uid ?? Uuid().v4(),
        size = size ?? ControllerSize(1920, 1080),
        backgrounds = backgrounds ?? <ControllerBackground>[],
        widgets = widgets ?? <ControllerWidget>[],
        nextLayerId = nextLayerId ?? 1,
        nextObjectId = nextObjectId ?? 1;

  String get name => path.split("/").last;

  @override
  List<Object?> get props => [
        uid,
        size,
        path,
        layer,
        backgrounds,
        widgets,
        nextLayerId,
        nextObjectId,
        path
      ];

  ControllerMap copyWith(
      {String? uid,
      ControllerSize? size,
      String? path,
      ControllerLayer? layer,
      List<ControllerBackground>? backgrounds,
      List<ControllerWidget>? widgets,
      int? nextLayerId,
      int? nextObjectId}) {
    return ControllerMap(
        path: path ?? this.path,
        layer: layer ?? this.layer,
        uid: uid ?? this.uid,
        size: size ?? this.size,
        backgrounds: backgrounds ?? this.backgrounds,
        widgets: widgets ?? this.widgets,
        nextLayerId: nextLayerId ?? this.nextLayerId,
        nextObjectId: nextObjectId ?? this.nextObjectId);
  }

  /// Deserializes the given [JsonMap] into a [ControllerMap].
  static ControllerMap fromJson(Map<String, dynamic> json) =>
      _$ControllerMapFromJson(json);

  /// Converts this [ControllerMap] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerMapToJson(this);
}
