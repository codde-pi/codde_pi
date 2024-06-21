import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/database.dart';
import 'package:flutter/material.dart';

import 'flame/play_controller_game.dart';

class PlayController extends StatelessWidget {
  final Project project;
  const PlayController({Key? key, required this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PlayControllerGame(project: project).overlayBuilder(context),
      builder: (context, snapshot) =>
          snapshot.data ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
