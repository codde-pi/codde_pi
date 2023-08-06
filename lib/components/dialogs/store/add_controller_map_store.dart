import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'add_controller_map_store.g.dart';

class AddControllerMapStore = _AddControllerMapStore
    with _$AddControllerMapStore;

abstract class _AddControllerMapStore with Store {
  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @action
  bool validate() {
    return formKey.currentState!.validate();
  }
}
