import 'dart:io';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:mobx/mobx.dart';

part 'file_tree_store.g.dart';

class FileTreeStore = _FileTreeStore with _$FileTreeStore;

abstract class _FileTreeStore with Store {
  _FileTreeStore({
    required this.cwd,
    TreeViewController? controller,
  }) : tree = controller ??
            TreeViewController(children: List<Node<FileSystemEntity>>.empty());

  @observable
  String cwd;
  @observable
  TreeViewController tree;

  @action
  void updateTree({List<Node<dynamic>> children = const [], String? key}) {
    tree = TreeViewController(children: children, selectedKey: key);
  }

  @action
  void setCwd(String path) {
    cwd = path;
  }
}
