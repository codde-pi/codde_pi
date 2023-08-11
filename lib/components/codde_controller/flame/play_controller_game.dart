import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_bloc.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_event.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_state.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_coddecom/flame_coddecom.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class PlayControllerGame extends FlameGame with HasGameRef {
  String path;
  PlayControllerBloc bloc;
  PlayControllerGame(this.bloc, this.path);
  // PlayControllerStore? store;
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(FlameBlocProvider<PlayControllerBloc, PlayControllerState>(
        create: () => bloc, children: [PlayControllerWrapper(path)]));
  }
}

class PlayControllerWrapper extends Component
    with FlameBlocReader<PlayControllerBloc, PlayControllerState> {
  String path;
  late TiledComponent mapComponent;
  final backend = GetIt.I.get<CoddeBackend>();
  ControllerProperties? props;
  PlayControllerWrapper(this.path);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    String content = '';
    await backend.read(path).then((value) => value.forEach((element) {
          content += "$element\n";
        }));
    mapComponent = await load(content, Vector2.all(16));
    // load props
    try {
      props =
          ControllerProperties.fromFlame(mapComponent.tileMap.map.properties);
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    if (props != null) {
      final Device? device = Hive.box<Device>("devices").get(props!.deviceId);
      assert(device?.address != null, "Address is not device :(");
      final view = PlayControllerView(
          path: path,
          builder: ProtocolBuilder().useSocketIO(
              device!.address!.contains("http")
                  ? device.address!
                  : "http://${device.address!}",
              OptionBuilder()
                  .setTransports(['websocket']) // for Flutter or Dart VM
                  .build()));

      view.add(mapComponent);
      add(view);
    } else {
      add(mapComponent);
    }
  }

  @override
  void onMount() {
    super.onMount();
    print('$runtimeType onMount');
    /* if (game.buildContext != null) {
      print('get store');
      store = GetIt.I.get<
          PlayControllerStore>(); //Provider.of<CoddeControllerStore>(gameRef.buildContext!);
    } */
    print('$runtimeType assign $props');
    bloc.add(PlayControllerPropsChanged(props));
  }

  static Future<TiledComponent> load(
    String fileContent,
    Vector2 destTileSize, {
    int? priority,
    bool? ignoreFlip,
  }) async {
    return CoddeTiledComponent(
      await RenderableTiledMap.fromString(
        fileContent,
        destTileSize,
        ignoreFlip: ignoreFlip,
      ),
      priority: priority,
    );
  }
}

class PlayControllerView extends FlameCoddeCom {
  String path;
  PlayControllerView({required this.path, required super.builder});
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    if (GetIt.I.isRegistered<CoddeCom>()) GetIt.I.unregister<CoddeCom>();
    GetIt.I.registerSingleton(com);
  }

  @override
  void onConnect() {
    print('Now connected !');
  }

  @override
  void onDisconnect() {
    print('Sorry, disconnected :/');
  }
}
