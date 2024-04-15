import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'add_controller_map_store.g.dart';

class AddControllerMapStore = _AddControllerMapStore
    with _$AddControllerMapStore;

abstract class _AddControllerMapStore with Store {
  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @observable
  String? fileExistsErr;
  @action
  bool validate() {
    return formKey.currentState!.validate();
  }

  @action
  void raiseFileExistsError(String error) {
    fileExistsErr = error;
  }

  @action
  void hideFileExistsError() {
    fileExistsErr = null;
  }
}
