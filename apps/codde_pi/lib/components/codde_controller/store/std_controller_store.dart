import 'package:mobx/mobx.dart';
part 'std_controller_store.g.dart';

class StdControllerStore = _StdControllerStore with _$StdControllerStore;

abstract class _StdControllerStore with Store {
  @observable
  String stdin = '';
  @observable
  String stdout = '';

  @action
  addIn(String txt) {
    stdin += txt;
  }

  @action
  addOut(String txt) {
    stdout += txt;
  }

  @action
  void clearIn() {
    stdin = '';
  }

  @action
  void clearOut() {
    stdout = '';
  }
}
