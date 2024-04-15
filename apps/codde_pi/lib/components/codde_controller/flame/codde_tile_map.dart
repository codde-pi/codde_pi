import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';

const TILE_SIZE = 32;

class CoddeTiledMap extends TiledMap {
  String path;
  CoddeTiledMap({
    required this.path,
    required super.width,
    required super.height,
    required super.tileWidth,
    required super.tileHeight,
    super.type = TileMapType.map,
    super.version = '1.0',
    super.tiledVersion,
    super.infinite = false,
    super.tilesets = const [],
    super.layers = const [],
    super.backgroundColorHex,
    super.backgroundColor,
    super.compressionLevel = -1,
    super.hexSideLength,
    super.nextLayerId,
    super.nextObjectId,
    super.orientation,
    super.renderOrder = RenderOrder.rightDown,
    super.staggerAxis,
    super.staggerIndex,
    super.editorSettings = const [],
    super.properties = CustomProperties.empty,
  });

  factory CoddeTiledMap.create(
      {required BuildContext context,
      String? uid,
      required String path,
      int? width,
      int? height,
      ControllerProperties properties = ControllerProperties.empty}) {
    final _width = width ?? MediaQuery.of(context).size.width;
    final _height = height ?? MediaQuery.of(context).size.height;
    return CoddeTiledMap(
      path: path.contains('.tmx') ? path : "$path.tmx",
      tileWidth: TILE_SIZE,
      tileHeight: TILE_SIZE,
      width: _width.toInt(),
      height: _height.toInt(),
      properties: properties,
      nextLayerId: 1,
      nextObjectId: 1,
    );
  }
}
