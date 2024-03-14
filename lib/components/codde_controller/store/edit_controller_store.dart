import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'edit_controller_store.g.dart';

class EditControllerStore = _EditControllerStore with _$EditControllerStore;

abstract class _EditControllerStore with Store {
  ObservableMap<int, ControllerWidget> repo =
      ObservableMap.of(<int, ControllerWidget>{});
}
