import 'package:flutter/material.dart';

import 'flame/play_controller_game.dart';

class PlayController extends StatelessWidget {
  final String path;
  const PlayController({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PlayControllerGame(path).overlayBuilder(context),
      builder: (context, snapshot) =>
          snapshot.data ?? Center(child: CircularProgressIndicator()),
    );
  }
}
