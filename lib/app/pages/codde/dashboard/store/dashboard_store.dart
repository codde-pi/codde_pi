import 'package:mobx/mobx.dart';
part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  @observable
  bool needCoddeReload = false;
  @action
  void askCoddeReload() {
    needCoddeReload = true;
  }
}
