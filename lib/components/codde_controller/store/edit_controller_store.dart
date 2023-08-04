import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'edit_controller_store.g.dart';

class EditControllerStore = _EditControllerStore with _$EditControllerStore;

abstract class _EditControllerStore with Store {
  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<PopupMenuButtonState<int>> popUpMenuKey = GlobalKey();

  @action
  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @action
  void showButtonMenu() {
    popUpMenuKey.currentState?.showButtonMenu();
  }
}
