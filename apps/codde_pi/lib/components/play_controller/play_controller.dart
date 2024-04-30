import 'package:codde_pi/services/db/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flame/play_controller_game.dart';

class PlayController extends StatelessWidget {
  final String path;
  const PlayController({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final project = Provider.of<Project>(context);
    return FutureBuilder(
      future: PlayControllerGame(workDir: path, device: project.device)
          .overlayBuilder(context),
      builder: (context, snapshot) =>
          snapshot.data ?? Center(child: CircularProgressIndicator()),
    );
  }
}
