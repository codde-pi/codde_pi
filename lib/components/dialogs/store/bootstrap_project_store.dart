import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'bootstrap_project_store.g.dart';

class BootstrapProjectStore = _BootstrapProjectStore
    with _$BootstrapProjectStore;

abstract class _BootstrapProjectStore with Store {
  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @action
  bool validate() {
    return formKey.currentState!.validate();
  }
}
