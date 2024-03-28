import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
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

  Future<bool> get isComOpen async => (GetIt.I.isRegistered<CoddeCom>() &&
      await GetIt.I.get<CoddeCom>().connected);
  Future<bool> get isRunning async =>
      GetIt.I.get<CoddeBackend>().isRunning || await isComOpen;

  @action
  void setExecutable(String? exec) {
    executable = exec;
  }
}
