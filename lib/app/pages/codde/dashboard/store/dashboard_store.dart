import 'package:mobx/mobx.dart';
part 'dashboard_store.g.dart';

class CoddeHostStore = _CoddeHostStore with _$CoddeHostStore;

abstract class _CoddeHostStore with Store {
  @observable
  bool needCoddeReload = false;
  @action
  void askCoddeReload() {
    needCoddeReload = true;
  }
}
