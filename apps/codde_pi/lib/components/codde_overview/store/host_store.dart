import 'package:mobx/mobx.dart';
part 'host_store.g.dart';

class HostStore = _HostStore with _$HostStore;

abstract class _HostStore with Store {
  @observable
  bool needCoddeReload = false;
  @action
  void askCoddeReload() {
    needCoddeReload = true;
  }
}
