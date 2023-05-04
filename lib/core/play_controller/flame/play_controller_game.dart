import 'dart:async';

import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/game.dart';
import 'package:flame_socketio/flame_socketio.dart';
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
        'http://0.0.0.0:8080',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    add(view);
  }
}

class PlayControllerView extends FlameSocketIOClient {
  String path;
  PlayControllerView(this.path, super.url, [super.options]);
  ControllerWidgetProvider provider =
      ControllerWidgetProvider(ControllerWidgetMode.player);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    late TiledComponent mapComponent;
    mapComponent = await TiledComponent.load(path, Vector2.all(16));
    add(mapComponent);

    List<Layer> layers = mapComponent.tileMap.map.layers;
    for (var value in layers) {
      add(provider.generateWidget(
          id: value.id!,
          class_: EnumToString.fromString(
              ControllerClass.values, value.class_ ?? ''),
          position: ControllerPosition(value.x, value.y))());
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
}
