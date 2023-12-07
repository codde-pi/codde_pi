import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'alert_dialog_form_store.g.dart';

class AlertDialogFormStore = _AlertDialogFormStore with _$AlertDialogFormStore;

abstract class _AlertDialogFormStore with Store {
  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @action
  bool validate() {
    return formKey.currentState!.validate();
  }
}
