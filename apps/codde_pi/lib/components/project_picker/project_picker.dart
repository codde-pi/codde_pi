import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/file_picker/file_picker.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';

class ProjectPicker extends StatefulWidget {
  String home;
  ProjectPicker({super.key, this.home = "/root"});
  @override
  State<StatefulWidget> createState() => _ProjectPicker();
}

class _ProjectPicker extends State<ProjectPicker> {
  late String selection = widget.home;
  List<FileEntity> children = [];
  late CoddeBackend backend = getBackend();

  @override
  void initState() {
    super.initState();
  }

  Future<List<FileEntity>> listChildren(String path) async {
    if (!backend.isOpen) {
      await backend.open();
    }
    List<FileEntity> list = await backend.listChildren(path);
    // list.sort((a, b) => a.path.compareTo(b.path));
    return list;
  }

  Stream<List<FileEntity>> listenChildren(String path) async* {
    if (!backend.isOpen) {
      await backend.open();
    }
    yield* backend.listenChildren(path);
  }

  void onSelect(FileEntity item) {
    item.isDir
        ? setState(() {
            selection = item.path;
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Project"),
        leading: IconButton(
            onPressed: () =>
                Navigator.of(context)..pop, // FIXME: stuck on black screen
            icon: const Icon(Icons.close)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(selection),
              child: const Text('VALIDATE')),
        ],
      ),
      body: FilePicker(backend: backend, path: selection, onSelect: onSelect),
    );
  }
}
