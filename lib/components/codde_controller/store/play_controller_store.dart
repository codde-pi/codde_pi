import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'play_controller_store.g.dart';

class PlayControllerStore = _PlayControllerStore with _$PlayControllerStore;

abstract class _PlayControllerStore with Store {
  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @action
  void toggleEndDrawer() {
    scaffoldKey.currentState!.isEndDrawerOpen
        ? scaffoldKey.currentState!.closeEndDrawer()
        : scaffoldKey.currentState!.openEndDrawer();
  }

  @action
  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
