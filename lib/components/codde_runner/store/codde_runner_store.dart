import 'package:codde_backend/codde_backend.dart';
import 'package:codde_com/codde_com.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'codde_runner_store.g.dart';

class CoddeRunnerStore = _CoddeRunnerStore with _$CoddeRunnerStore;

abstract class _CoddeRunnerStore with Store {
  @observable
  SSHSession? session;
  @observable
  String lastStd = "";
  @observable
  String? executable;

  _CoddeRunnerStore({this.executable});

  @action
  void createSession(SSHSession? session) => this.session = session;

  @action
  writeStd(String std) => lastStd = std;

  bool get isComOpen =>
      (GetIt.I.isRegistered<CoddeCom>() && GetIt.I.get<CoddeCom>().connected);
  bool get isRunning => GetIt.I.get<CoddeBackend>().isRunning || isComOpen;

  @action
  void setExecutable(String? exec) {
    executable = exec;
  }
}
