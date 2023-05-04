import 'package:codde_pi/core/play_controller/flame/play_controller_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayControllerPage extends StatelessWidget {
  final path = 'map.tmx';

  const PlayControllerPage({super.key}); // TODO: load project

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
          title: const Text('Play Controller Name'), // TODO: path name
        ),
        body: GameWidget(game: PlayControllerGame(path)));
  }
}
