import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller_map.g.dart';

@JsonSerializable()
class ControllerMap extends Equatable {
  final String uid;
  final String path;
  final List<ControllerBackground>? backgrounds;
  final int? nextLayerId;
  final int? nextObjectId;
  final int? width;
  final int? height;
  final ControllerProperties? properties;

  ControllerMap(
      {required this.path,
      String? uid,
      this.width,
      this.height,
      this.backgrounds,
      this.nextLayerId,
      this.nextObjectId,
      this.properties})
      : uid = uid ?? Uuid().v4();

  String get name => path.split("/").last;

  // TODO: create init() function/constructor in case new ControllerMap is CREATED
  // otherwise all props are null or empties
  /* uid = uid ?? Uuid().v4(),
        size = size ?? ControllerSize(1920, 1080),
        backgrounds = backgrounds ?? <ControllerBackground>[],
        widgets = widgets ?? <ControllerWidget>[],
        nextLayerId = nextLayerId ?? 1,
        nextObjectId = nextObjectId ?? 1; */

  @override
  List<Object?> get props => [
        uid,
        path,
        backgrounds,
        nextLayerId,
        nextObjectId,
        path,
        width,
        height,
        properties
      ];

  ControllerMap copyWith(
      {String? uid,
      int? width,
      int? height,
      String? path,
      List<ControllerBackground>? backgrounds,
      int? nextLayerId,
      int? nextObjectId,
      ControllerProperties? controller_props}) {
    return ControllerMap(
        path: path ?? this.path,
        uid: uid ?? this.uid,
        backgrounds: backgrounds ?? this.backgrounds,
        nextLayerId: nextLayerId ?? this.nextLayerId,
        nextObjectId: nextObjectId ?? this.nextObjectId,
        width: width ?? this.width,
        height: height ?? this.height,
        properties: controller_props ?? this.properties);
  }

  /// Deserializes the given [JsonMap] into a [ControllerMap].
  static ControllerMap fromJson(Map<String, dynamic> json) =>
      _$ControllerMapFromJson(json);

  /// Converts this [ControllerMap] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerMapToJson(this);
}
