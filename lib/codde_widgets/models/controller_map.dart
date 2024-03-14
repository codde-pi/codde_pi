import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:xml/xml.dart';

part 'controller_map.freezed.dart';

@freezed
class ControllerMap with _$ControllerMap {
  static const TILE_SIZE = 32;
  const ControllerMap._();

  factory ControllerMap({required String path, required TiledMap map}) =>
      ControllerMap._genUid(path: path, map: map);
  const factory ControllerMap._genUid(
      {required String path, required TiledMap map}) = _ControllerMap;

  factory ControllerMap.create(
      {required BuildContext context,
      required String path,
      int? width,
      int? height,
      ControllerProperties? properties}) {
    return ControllerMap(
      path: path.contains('.tmx') ? path : "$path.tmx",
      map: TiledMap(
          width: (width ?? MediaQuery.of(context).size.width).toInt(),
          height: (height ?? MediaQuery.of(context).size.height).toInt(),
          properties: properties ?? CustomProperties.empty,
          nextLayerId: 1,
          nextObjectId: 1,
          tileWidth: TILE_SIZE,
          tileHeight: TILE_SIZE),
    );
  }

  String get name => path.split("/").last;

  CoddeBackend get backend => GetIt.I.get<CoddeBackend>();

  XmlDocument get document => map.build();

  Future<FileEntity> createMap() {
    return backend.create(path, content: document.toXmlString());
  }

  Future<FileEntity> saveMap() {
    return backend.save(path, document.toXmlString());
  }
}
