import 'package:codde_pi/components/add_widget/add_widget_dialog.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PlayControllerPage extends StatelessWidget {
  final String path;
  final bar = GetIt.I.get<DynamicBarState>();

  PlayControllerPage({required this.path, super.key});
  final GlobalKey<PopupMenuButtonState<int>> _popUpMenuKey = GlobalKey();
  final store = PlayControllerStore();
  @override
  Widget build(BuildContext context) {
    final coddeStore = Provider.of<CoddeControllerStore>(context);
    bar.setFab(
      iconData: Icons.play_arrow_outlined,
      action: () {
        /* TODO: ask codde_com to open connection */
        print('RUN');
      },
      extended: IconButton(
          onPressed: () => coddeStore.editMode(), icon: const Icon(Icons.edit)),
    );
    return Scaffold(
        key: store.scaffoldKey,
        appBar: AppBar(
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
}
