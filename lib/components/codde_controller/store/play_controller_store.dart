import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'play_controller_store.g.dart';

class PlayControllerStore = _PlayControllerStore with _$PlayControllerStore;

abstract class _PlayControllerStore with Store {
  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @observable
  ControllerProperties? properties;

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

  @action
  setProperties(ControllerProperties? props) {
    properties = props;
  }

  @computed
  String? get executable => properties?.executable;
}
