import 'package:mobx/mobx.dart';

import 'toolbar_event.dart';

part 'toolbar_store.g.dart';

class ToolBarStore = _ToolBarStore with _$ToolBarStore;

abstract class _ToolBarStore with Store {
  @observable
  bool ctrlEnabled = false;
  @observable
  bool altEnabled = false;
  @observable
  ToolBarEvent? event;
  @action
  void ctrlKey() {
    ctrlEnabled = !ctrlEnabled;
  }

  @action
  void altKey() {
    altEnabled = !altEnabled;
  }

  @action
  sendEvent(ToolBarEvent event) {
    event = event;
  }
}
