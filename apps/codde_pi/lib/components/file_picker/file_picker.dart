// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/dialogs/add_file_dialog.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FilePicker extends StatelessWidget {
  CoddeBackend backend;
  String path;
  Function(FileEntity entity) onSelect;
  bool readOnly;

  FilePicker(
      {super.key,
      this.readOnly = true,
      required this.backend,
      required this.path,
      required this.onSelect});

  Stream<List<FileEntity>> listenChildren(String path) async* {
    if (!backend.isOpen) {
      await backend.open();
    }
    yield* backend.listenChildren(path);
  }

  void addItem({required BuildContext context}) async {
    FileEntity fileEntity = await showDialog(
        context: context, builder: (context) => AddFileDialog());
    fileEntity.path = join(path, fileEntity.name);
    fileEntity.isDir
        ? await backend.mkdir(fileEntity.path)
        : await backend.create(fileEntity.path);
    onSelect(fileEntity);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: listenChildren(path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            // logger.d("Children: ${snapshot.data?.length}");
            if (!readOnly)
              snapshot.data?.add(
                  FileEntity('', false)); // create new entry for `Add` button
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                if (index == snapshot.data!.length - 1 && !readOnly) {
                  return ListTile(
                    title: Text('Add'),
                    leading: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () => addItem(context: context),
                  );
                }
                final FileEntity item = snapshot.data!.elementAt(index);
                return ListTile(
                  title: Text(item.name),
                  leading: item.isDir
                      ? const Icon(
                          Icons.folder,
                          color: Colors.blue,
                        )
                      : const Icon(Icons.file_open_sharp),
                  onTap: () => onSelect(item),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Nothing to show. Please retry later'),
            );
          }
        });
  }
}
