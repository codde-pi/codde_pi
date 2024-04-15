import 'package:flutter/material.dart';

class ProjectLocationDialog extends SimpleDialog {
  final Function navigateLocal;
  final Function navigateRemote;
  const ProjectLocationDialog(
      {super.key, required this.navigateLocal, required this.navigateRemote});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Project Location"),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: navigateLocal(),
          child: const Text('Local'),
        ),
        SimpleDialogOption(
          onPressed: navigateRemote(),
          child: const Text('Remote'),
        ),
      ],
    );
  }
}
