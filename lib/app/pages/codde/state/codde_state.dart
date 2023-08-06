import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:mobx/mobx.dart';

part 'codde_state.g.dart';

class CoddeState = _CoddeState with _$CoddeState;

abstract class _CoddeState with Store {
  @observable
  Project project;

  _CoddeState(this.project);
  @action
  void selectHost(Host host) {
    project.host = host;
  }
}
