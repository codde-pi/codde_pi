import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'codde_editor_store.g.dart';

class CoddeEditorStore = _CoddeEditorStore with _$CoddeEditorStore;

abstract class _CoddeEditorStore with Store {
  final GlobalKey<ScaffoldState> scaffoldKey;
  double fileTreeWidth = 200.0;
  bool fileTreeOpen = false;
  _CoddeEditorStore({GlobalKey<ScaffoldState>? scaffoldState})
      : scaffoldKey = scaffoldState ?? GlobalKey<ScaffoldState>();

  @action
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  /// Toggle fileTree located as Scaffold Drawer
  @action
  void toggleFileTree(bool drawer) {
    if (drawer) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeDrawer();
      } else {
        scaffoldKey.currentState!.openDrawer();
      }
      fileTreeOpen = scaffoldKey.currentState!.isDrawerOpen;
      return;
    }
    fileTreeOpen = !fileTreeOpen;
  }

  @action
  void saveFileTreeWidth() {
    throw Exception("Not yet implemented :/");
  }

  @action
  void updateFileTreeWidth(width) {
    throw Exception("Not yet implemented :/");
  }
}
