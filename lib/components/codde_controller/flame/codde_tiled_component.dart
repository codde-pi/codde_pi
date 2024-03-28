import 'dart:async';

import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/utils/hatch_background.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

/// [CoddeTiledComponent] Place generated widget in [onMount] in order to use gameRef
///  and get current material colors
class CoddeTiledComponent extends TiledComponent with HasGameRef {
  ControllerWidgetMode mode;
  String content;

  @override
  CoddeTiledComponent(super.tileMap,
      {required this.mode, super.scale, super.position})
      : content = tileMap.map.toString();

  static Future<CoddeTiledComponent> load(String content,
          {required ControllerWidgetMode mode,
          int? priority,
          Vector2? scale,
          Vector2? position}) async =>
      CoddeTiledComponent(await _load(content, Vector2.all(16)),
          mode: mode, scale: scale, position: position);

  @override
  void onMount() async {
    super.onMount();
    /* PURPOSE TEST ONLY:
    var videoStream = MjpegStreamComponent.parseUri(
        uri: "http://192.168.0.40:8080/?action=stream");
    add(videoStream); */
    // Load MAP
    if (mode == ControllerWidgetMode.editor) {
      add(CustomPainterComponent(
          size: Vector2.all(1),
          painter: HatchBackground(
              colorscheme: Theme.of(gameRef.buildContext!).colorScheme)));
    }
    for (var layer in tileMap.map.layers) {
      if (game.buildContext != null) {
        if (layer.id != null && layer.type == LayerType.objectGroup) {
          add(
            await generateWidget(
                mode: mode,
                context: gameRef.buildContext!,
                id: layer.id!,
                class_: EnumToString.fromString(
                        ControllerClass.values, layer.class_ ?? '') ??
                    ControllerClass.error,
                properties: layer.properties,
                x: layer.x,
                y: layer.y) as Component,
          );
        }
      }
    }
  }

  static Future<RenderableTiledMap> _load(
    String fileContent,
    Vector2 destTileSize, {
    int? priority,
    bool? ignoreFlip,
  }) async {
    return await RenderableTiledMap.fromString(
      fileContent,
      destTileSize,
      ignoreFlip: ignoreFlip,
    );
  }
}
