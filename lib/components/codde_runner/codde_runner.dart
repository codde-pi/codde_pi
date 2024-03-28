import 'package:backdrop/backdrop.dart';
import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/play_controller_game.dart';
import 'package:codde_pi/components/codde_runner/store/codde_runner_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

import 'views/runtime_std_view.dart';

/// [CoddeRunner] Page run scripts (.sh, .py, .rs) and controllers
/// Scripts need a valid SSH connection
/// Controllers are read and generated in [PlayControllerGame] component
/// [CoddeCom] and [CoddeBackend] sessions are shared between these pages
class CoddeRunner extends StatefulWidget {
  final String exec;
  const CoddeRunner(this.exec, {super.key});
  @override
  State<StatefulWidget> createState() => _CoddeRunner();
}

class _CoddeRunner extends State<CoddeRunner> {
  CoddeBackend get backend => GetIt.I.get<CoddeBackend>();
  final CoddeRunnerStore store = CoddeRunnerStore();
  late String exec = widget.exec;

  @override
  void dispose() {
    super.dispose();
    stopExec();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => BackdropScaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.delete)),
            title: Text(basename(exec))),
        stickyFrontLayer: !isControllerFile(exec),
        subHeader: BackdropSubHeader(title: Text(store.lastStd)),
        revealBackLayerAtStart: isControllerFile(exec),
        backLayer: isControllerFile(exec)
            ? GameWidget(game: PlayControllerGame(widget.exec))
            : Container(), // TODO: message for user OR exposed code source ?
        frontLayer: RuntimeStdView(command),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await store.isRunning
                ? (isControllerFile(exec) ? runController() : runExec())
                : stopExec();
          },
          child: FutureBuilder(
              future: store.isRunning,
              initialData: false,
              builder: (context, snapshot) =>
                  Icon(snapshot.data! ? Icons.stop : Icons.play_arrow)),
        ),
      ),
    );
  }

  void runExec() async {
    store.createSession(await backend.client?.execute(command));
  }

  void runController() async {
    final props = GetIt.I.get<ControllerProperties>();
    if (props.executable != null) {
      store.createSession(
          await backend.client?.execute(getCommand(props.executable!)));
    }
    final com = GetIt.I.get<CoddeCom>();
    com.connect();
    await store.session?.done.whenComplete(() {
      /* ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            runResSnackBar(
                exitCode: session.exitCode,
                signal: session.exitSignal?.signalName)); */
      print('exitCode: ${store.session?.exitCode}'); // -> exitCode: null
      print(
          'signal: ${store.session?.exitSignal?.signalName}'); // -> signal: KILL
      stopExec(); // TODO: check potential issues
    });
  }

  String getCommand(String exec) =>
      "cd ${dirname(widget.exec)}; ${runPrefix(exec, inCwd: true)}";

  String get command => getCommand(exec);

  void stopExec() async {
    if (await store.isComOpen) GetIt.I.get<CoddeCom>().disconnect();
    store.session?.kill(SSHSignal.TERM);
    store.session?.close();
  }
}
