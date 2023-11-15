import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/components/codde_controller/bloc/play_controller_bloc.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dialogs/codde_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/store/dynamic_bar_store.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class PlayControllerPage extends DynamicBarStatefulWidget {
  final String path;
  PlayControllerPage({required this.path, super.key});

  @override
  DynamicBarStateWidget<DynamicBarStatefulWidget> createDynamicState() =>
      PlayControllerPageState();
}

class PlayControllerPageState
    extends DynamicBarStateWidget<PlayControllerPage> {
  @override
  final bar = GetIt.I.get<DynamicBarStore>();
  GlobalKey<PopupMenuButtonState<int>> popUpMenuKey =
      GlobalKey<PopupMenuButtonState<int>>();

  final store = GetIt.I.isRegistered<PlayControllerStore>()
      ? GetIt.I.get<PlayControllerStore>()
      : GetIt.I.registerSingleton(PlayControllerStore());
  final bloc = PlayControllerBloc();
  CoddeControllerStore? coddeStore;

  /* @override
  void dispose() {
    GetIt.I.unregister(instance: store);
    super.dispose();
  } */

  void runProject() async {
    final backend = GetIt.I.get<CoddeBackend>();
    final com = GetIt.I.get<CoddeCom>();
    com.connect();
    if (bloc.state.executable != null) {
      print('executable ${bloc.state.executable}');
      final cd =
          "cd ${p.dirname(widget.path)};"; // TODO: get project.path instead
      final session =
          await backend.session?.execute("$cd ${bloc.state.executable!}");

      bar.setFab(
          iconData: Icons.stop,
          action: () async {
            session?.kill(SSHSignal.TERM);
            print('exitCode: ${session?.exitCode}'); // -> exitCode: null
            print(
                'signal: ${session?.exitSignal?.signalName}'); // -> signal: KILL
            bar.setFab(iconData: Icons.play_arrow_outlined, action: runProject);
          });
      await session?.done.whenComplete(() {
        bar.setFab(
            iconData: Icons.play_arrow_outlined, action: () => runProject());
        /* ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            runResSnackBar(
                exitCode: session.exitCode,
                signal: session.exitSignal?.signalName)); */
        print('exitCode: ${session.exitCode}'); // -> exitCode: null
        print('signal: ${session.exitSignal?.signalName}'); // -> signal: KILL
      });
    } /* else {
      bar.setFab(iconData: Icons.link_off, action: com.disconnect);
    } */
    else {
      print('no executable');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    coddeStore = Provider.of<CoddeControllerStore>(context);
    return Scaffold(
      // key: store.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => coddeStore?.editMode(),
            icon: const Icon(Icons.edit)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => store.openEndDrawer(),
              icon: const Icon(Icons.analytics)),
          Observer(
            builder: (context) => PopupMenuButton(
              key: popUpMenuKey,
              itemBuilder: (_) => <PopupMenuItem>[
                PopupMenuItem(
                  value: 0,
                  child: const material.Text('Controlled device'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      // final _store = GetIt.I.get<PlayControllerStore>();
                      print('$runtimeType sharing ${bloc.state.properties}');
                      final props = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CoddeDeviceDialog(
                              properties: bloc.state.properties),
                        ),
                      );
                      if (props != null) changeProperties(context, props);
                    });
                  },
                ),
              ],
            ),
          )
        ],
        title: material.Text(widget.path.split('/').last),
      ),
      endDrawer: StdControllerView(),
      body: /* Provider(
          create: (_) => store,
          child: */
          GameWidget(game: PlayControllerGame(bloc, widget.path)),
      //),
    );
  }

  @override
  setFab(BuildContext context) {
    bar.setFab(
      iconData: Icons.play_arrow_outlined,
      action: () {
        runProject();
        /* TODO: ask codde_com to open connection */
        print('RUN');
      },
      extended: IconButton(
          onPressed: () => coddeStore?.editMode(),
          icon: const Icon(Icons.edit)),
    );
  }

  void changeProperties(
      BuildContext context, ControllerProperties props) async {
    print('PATH = ${widget.path}');
    final map = ControllerMap(path: widget.path, properties: props);
    final api = ControllerWidgetApi(map: map);
    FileEntity? file;
    try {
      file = await api.saveProperties();
    } catch (e) {
      print('raise error $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: material.Text(e.toString())));
      return;
    } finally {
      // if done, refresh
      setState(() {});
    }
  }

  @override
  void setIndexer(context) {}

  @override
  get bottomMenu => null;
}

SnackBar runResSnackBar({required exitCode, required signal}) => SnackBar(
    content:
        material.Text("Program done. \nexitCode: $exitCode, Signal: $signal"));
