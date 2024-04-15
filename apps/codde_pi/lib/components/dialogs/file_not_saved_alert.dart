import 'package:codde_editor/codde_editor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Warn user that the specified [FileStack] object to close is not yet saved.
class FileNotSavedAlert extends StatelessWidget {
  final String uid;
  const FileNotSavedAlert({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
    final repo = GetIt.I.get<FileStackManager>();
    return AlertDialog(
      title: const Text("Warning"),
      content: Text("${repo.fileStacks[uid]?.name} is not saved."),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("CANCEL")),
        TextButton(
            onPressed: () => repo.closeFile(uid, force: true),
            child: const Text("DISCARD CHANGES")),
        TextButton(
            onPressed: () => repo.saveFile(uid), child: const Text("SAVE")),
      ],
    );
  }
}
