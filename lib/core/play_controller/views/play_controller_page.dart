import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_controller.dart';
import 'package:codde_pi/core/codde_controller/state/codde_controller_controller.dart';
import 'package:codde_pi/core/play_controller/flame/play_controller_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayControllerPage extends StatelessWidget {
  final String path;

  PlayControllerPage({required this.path, super.key});
  final GlobalKey<PopupMenuButtonState<int>> _popUpMenuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    setFab(
        iconData: Icons.play_arrow_outlined,
        action: () {
          /* TODO */ print('RUN');
        });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () =>
                    Get.find<CoddeControllerController>().editMode(),
                icon: const Icon(Icons.edit)),
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
        body: GameWidget(game: PlayControllerGame(path)));
  }
}
