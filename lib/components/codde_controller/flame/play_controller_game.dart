import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_bloc.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_event.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_state.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/components/codde_runner/store/codde_runner_store.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_coddecom/flame_coddecom.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';
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
  late CustomProperties props;
  PlayControllerWrapper(this.path);
  late CoddeRunnerStore runnerStore = GetIt.I.get<CoddeRunnerStore>();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    String content = '';
    await backend.read(path).then((value) => value.forEach((element) {
          content += "$element\n";
        }));
    mapComponent = await CoddeTiledComponent.load(content,
        provider: ControllerWidgetProvider(ControllerWidgetMode.player));
    // load props
    try {
      props = mapComponent.tileMap.map.properties;
    } catch (e) {
      print('ERROR: $e');
    } //on ControllerPropertiesException catch (_) {}
    final Device? device =
        Hive.box<Device>("devices").get(props!.getValue<int>("deviceId"));
    if (device != null) {
      // TODO: remove assert, disable run button and show snackbar warning
      assert(device.address != null, "Address is not device :(");
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
    bloc.add(PlayControllerPropsChanged(ControllerProperties(props.byName)));
    // TODO: test
    if (GetIt.I.isRegistered<ControllerProperties>()) {
      GetIt.I.unregister<ControllerProperties>();
    }
    GetIt.I.registerLazySingleton(() => ControllerProperties(props.byName));
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
