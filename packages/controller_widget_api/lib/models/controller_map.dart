import 'package:codde_com/codde_com.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller_map.g.dart';
part 'controller_map.freezed.dart';

@freezed
class ControllerMap with _$ControllerMap {
  static const TILE_SIZE = 16.0;
  const ControllerMap._();

  factory ControllerMap(
          {required String path,
          String? uid,
          int? width,
          int? height,
          int? nextLayerId,
          int? nextObjectId,
          ControllerProperties? properties}) =>
      ControllerMap._genUid(
          path: path,
          uid: uid ?? Uuid().v4(),
          width: width,
          height: height,
          nextObjectId: nextObjectId,
          nextLayerId: nextLayerId,
          properties: properties);
  const factory ControllerMap._genUid(
      {required String path,
      String? uid,
      int? width,
      int? height,
      int? nextLayerId,
      int? nextObjectId,
      ControllerProperties? properties}) = _ControllerMap;

  factory ControllerMap.create(
      {required BuildContext context,
      String? uid,
      required String path,
      int? width,
      int? height,
      ControllerProperties? properties}) {
    final _width = width ?? MediaQuery.of(context).size.width;
    final _height = height ?? MediaQuery.of(context).size.height;
    return ControllerMap(
      path: path.contains('.tmx') ? path : "$path.tmx",
      width: _width.toInt(),
      height: _height.toInt(),
      properties:
          properties ?? ControllerProperties(protocol: CoddeProtocol.socketio),
      nextLayerId: 1,
      nextObjectId: 1,
    );
  }

  String get name => path.split("/").last;

  /// Deserializes the given [Map] into a [ControllerMap]
  factory ControllerMap.fromJson(Map<String, Object?> json) =>
      _$ControllerMapFromJson(json);
}
