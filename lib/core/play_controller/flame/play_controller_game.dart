import 'dart:async';
import 'dart:io';

import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/game.dart';
import 'package:flame_coddecom/flame_coddecom.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:socket_io_client/socket_io_client.dart';

class PlayControllerGame extends FlameGame {
  String path;
  PlayControllerGame(this.path);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /* final sock = io(
        'http://localhost:8080',
        );
    sock.connect();
    sock.onConnect((_) {
      print('connect');
      sock.emit('my_event', 'test');
    });
    print('emitting');
    sock.emit('my custom event', 'data');
    sock.emit('my_event', 'data'); */

    final view = PlayControllerView(
        path,
        CoddeProtocol.socketio,
        ProtocolBuilder().useSocketIO(
            'http://0.0.0.0:8080',
            OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'foo': 'bar'}) // optional
                .build()));

    add(view);
  }
}

class PlayControllerView extends FlameCoddeCom {
  String path;
  PlayControllerView(this.path, super.protocol, super.builder);
  ControllerWidgetProvider provider =
      ControllerWidgetProvider(ControllerWidgetMode.player);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    final content = await File(path).readAsString();
    late TiledComponent mapComponent;
    mapComponent = await load(content, Vector2.all(16));
    add(mapComponent);

    List<Layer> layers = mapComponent.tileMap.map.layers;
    for (var value in layers) {
      add(provider.generateWidget(
          id: value.id!,
          class_: EnumToString.fromString(
              ControllerClass.values, value.class_ ?? ''),
          x: value.x,
          y: value.y)());
    }
  }

  @override
  void onConnect(Function(dynamic p1) connect) {
    print('Now connected !');
  }

  @override
  void onDisconnect(Function(dynamic p1) disconnect) {
    print('Sorry, disconnected :/');
  }

  static Future<TiledComponent> load(
    String fileContent,
    Vector2 destTileSize, {
    int? priority,
    bool? ignoreFlip,
  }) async {
    return TiledComponent(
      await RenderableTiledMap.fromString(
        fileContent,
        destTileSize,
        ignoreFlip: ignoreFlip,
      ),
      priority: priority,
    );
  }
}
