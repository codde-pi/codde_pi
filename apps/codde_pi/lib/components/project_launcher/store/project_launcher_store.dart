import 'package:codde_pi/services/db/database.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'project_launcher_store.g.dart';

class ProjectLauncherStore = _ProjectLauncherStore with _$ProjectLauncherStore;

abstract class _ProjectLauncherStore with Store {
  /* @observable
  ProjectPathType pathType = ProjectPathType.folder; */

  @observable
  Project? project;

  @observable
  bool hostLater = false;

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  bool validate() {
    return formKey.currentState!.validate();
  }

  @observable
  int progress = 0;

  @action
  void continueSetup() {
    progress += 1;
  }

  @observable
  Device? selectedDevice;

  @action
  setDevice(Device device) {
    selectedDevice = device;
  }
}
