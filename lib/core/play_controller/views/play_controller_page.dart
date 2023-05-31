import 'package:codde_pi/core/play_controller/flame/play_controller_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayControllerPage extends StatelessWidget {
  final String path;

  const PlayControllerPage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
          title: Text(path.split('/').last), // TODO: path name
        ),
        body: GameWidget(game: PlayControllerGame(path)));
  }
}
