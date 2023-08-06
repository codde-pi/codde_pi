import 'dart:async';
import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_coddecom/flame_coddecom.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:get_it/get_it.dart';
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
        path: path,
        builder: ProtocolBuilder().useSocketIO(
            'http://0.0.0.0:8080',
            OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'foo': 'bar'}) // optional
                .build()));

    add(view);
  }
}

class PlayControllerView extends FlameCoddeCom with HasGameRef {
  String path;
  PlayControllerView({required this.path, required super.builder});
  ControllerWidgetProvider provider =
      ControllerWidgetProvider(ControllerWidgetMode.player);
  List layers = [];
  late TiledComponent mapComponent;
  final backend = GetIt.I.get<CoddeBackend>();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    String content = '';
    await backend.read(path).then((value) => value.forEach((element) {
          content += "$element\n";
        }));
    mapComponent = await load(content, Vector2.all(16));
    add(mapComponent);

    layers = mapComponent.tileMap.map.layers;
  }

  @override
  void onMount() async {
    super.onMount();
    for (var value in layers) {
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
