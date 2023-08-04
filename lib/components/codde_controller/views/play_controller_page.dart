import 'dart:io';
import 'dart:typed_data';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PlayControllerPage extends StatelessWidget with DynamicFabSelector {
  final String path;
  // final bar = GetIt.I.get<DynamicBarState>();

  PlayControllerPage({required this.path, super.key});
  final GlobalKey<PopupMenuButtonState<int>> _popUpMenuKey = GlobalKey();
  final store = PlayControllerStore();
  late final CoddeControllerStore coddeStore;

  void runProject() async {
    final backend = GetIt.I.get<CoddeBackend>();
    final com = GetIt.I.get<CoddeCom>();
    if (coddeStore.executable != null) {
      final session = await backend.session.execute(coddeStore.executable!);

      bar.setFab(
          iconData: Icons.stop,
          action: () async {
            session.kill(SSHSignal.TERM);
            print('exitCode: ${session.exitCode}'); // -> exitCode: null
            print(
                'signal: ${session.exitSignal?.signalName}'); // -> signal: KILL
          });
      await session.done.whenComplete(() {
        bar.setFab(
            iconData: Icons.play_arrow_outlined, action: () => runProject);
        /* TODO: ScaffoldMessenger.of(context).showSnackBar(RunResSnackBar(
            exitCode: session.exitCode,
            signal: session.exitSignal?.signalName)); */
      });
    } else {
      bar.setFab(iconData: Icons.link_off, action: com.disconnect);
    }
  }

  @override
  Widget build(BuildContext context) {
    coddeStore = Provider.of<CoddeControllerStore>(context);
    return Scaffold(
        key: store.scaffoldKey,
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () => coddeStore.editMode(),
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () => store.openEndDrawer(),
                icon: const Icon(Icons.menu)),
            PopupMenuButton(
                key: _popUpMenuKey,
                itemBuilder: (_) => const <PopupMenuItem>[
                      PopupMenuItem(value: 0, child: Text('Show logs'))
                    ],
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () =>
                        _popUpMenuKey.currentState?.showButtonMenu()))
          ],
          title: Text(path.split('/').last),
        ),
        endDrawer: StdControllerView(),
        body: GameWidget(game: PlayControllerGame(path)));
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
          onPressed: () => coddeStore.editMode(), icon: const Icon(Icons.edit)),
    );
  }
}
