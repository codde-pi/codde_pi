import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_editor/codde_editor.dart';
import 'package:codde_pi/components/dialogs/file_not_saved_alert.dart';
import 'package:codde_pi/logger.dart';
import 'store/file_tree_store.dart';
import 'package:codde_pi/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';

class FileTreeView extends StatelessWidget {
  FileTreeView(String cwd, {super.key}) : fileTree = FileTreeStore(cwd: cwd);

  FileTreeStore fileTree;

  FileStackManager repo = GetIt.I.get<FileStackManager>();
  CoddeBackend backend = GetIt.I.get<CoddeBackend>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Node<FileEntity>>>(
        future: listRootFiles(fileTree.cwd),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          if (snapshot.data != null) {
            fileTree.updateTree(children: snapshot.data!);
          }
          if (fileTree.tree.children.isEmpty) {
            const Center(child: Text('No file'));
          }
          return Observer(
            builder: (_) => TreeView(
              theme: theme.treeViewTheme,
              controller: fileTree.tree,
              onNodeTap: (key) async {
                Node<FileEntity>? node = fileTree.tree.getNode(key);
                if (node != null) {
                  if (await backend.isDirectory(node.key) == true) {
                    var updated = fileTree.tree.updateNode(
                        key,
                        node.copyWith(
                            expanded: !node.expanded,
                            children: !node.expanded
                                ? await listFiles(node.key)
                                : []));
                    fileTree.updateTree(children: updated);
                    //TODO: isolateUpdateEntities();
                    logger.i('updated');
                  } else {
                    try {
                      repo.openFile(node.key);
                    } on FileStackNotSavedError {
                      await showDialog(
                          context: context,
                          builder: (context) =>
                              FileNotSavedAlert(uid: repo.focusedId!));
                    } finally {
                      Navigator.of(context).pop();
                    }
                  }
                }
              },
            ),
          );
        });
  }

  Future<List<Node<FileEntity>>>? listRootFiles(String path) {
    if (fileTree.tree.children.isNotEmpty) {
      return null;
    }
    return listFiles(path);
  }

  Future<List<Node<FileEntity>>> listFiles(String path) async {
    var list = await backend.listChildren(path);
    List<Node<FileEntity>> list2 = list.map<Node<FileEntity>>((e) {
      return Node<FileEntity>(key: e.path, label: e.name, parent: e.isDir);
    }).toList();

    return list2;
  }
}
