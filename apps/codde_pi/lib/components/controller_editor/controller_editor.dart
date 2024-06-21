import 'package:codde_pi/components/controller_editor/flame/controller_editor_game.dart';
import 'package:flutter/material.dart';

class ControllerEditor extends StatefulWidget {
  String path;
  ControllerEditor({required this.path, super.key});

  @override
  State<StatefulWidget> createState() => _ControllerEditor();
}

class _ControllerEditor extends State<ControllerEditor> {
  /* GlobalKey<PopupMenuButtonState<int>> popUpMenuKey =
      GlobalKey<PopupMenuButtonState<int>>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); */

  // save game state
  // late final game = ControllerEditorGame(widget.path);

  @override
  Widget build(BuildContext context) {
    return ControllerEditorGame(widget.path).overlayBuilder(context);
  }
}
