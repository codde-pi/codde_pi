import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';
import 'package:flame_tiled/flame_tiled.dart';

/// [CoddeTiledComponent] Place generated widget in [onMount] in order to use gameRef
///  and get current material colors
class CoddeTiledComponent extends TiledComponent {
  ControllerWidgetProvider provider;
  String content;
  CoddeTiledComponent(super.tileMap,
      {required this.provider, super.scale, super.position})
      : content = tileMap.map.toString();

  static Future<CoddeTiledComponent> load(String content,
          {required ControllerWidgetProvider provider,
          int? priority,
          Vector2? scale,
          Vector2? position}) async =>
      CoddeTiledComponent(await _load(content, Vector2.all(16)),
          provider: provider, scale: scale, position: position);

  @override
  void onMount() async {
    super.onMount();
    /* PURPOSE TEST ONLY:
    var videoStream = MjpegStreamComponent.parseUri(
        uri: "http://192.168.0.40:8080/?action=stream");
    add(videoStream); */
    for (var value in tileMap.map.layers) {
      if (game.buildContext != null) {
        add(await provider.generateWidget(
            context: gameRef.buildContext!,
            id: value.id!,
            class_: EnumToString.fromString(
                    ControllerClass.values, value.class_ ?? '') ??
                ControllerClass.unknown,
            x: value.x,
            y: value.y));
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
