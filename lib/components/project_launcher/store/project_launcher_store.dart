import 'package:codde_pi/components/dialogs/store/select_host_store.dart';
import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/file_or_folder_step.dart';
import 'package:codde_pi/components/project_launcher/utils/project_launcher_utils.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'project_launcher_store.g.dart';

class ProjectLauncherStore = _ProjectLauncherStore with _$ProjectLauncherStore;

abstract class _ProjectLauncherStore with Store {
  @observable
  ProjectType projectType = ProjectType.codde_pi;

  /* @observable
  ProjectPathType pathType = ProjectPathType.folder; */

  SelectHostStore selectHostStore = SelectHostStore();

  @action
  setProjectType(ProjectType type) {
    projectType = type;
  }

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

  @computed
  bool get validable => (projectType == ProjectType.controller ||
      selectHostStore.selectedHost != null ||
      hostLater);

  @observable
  int progress = 0;

  @action
  void continueSetup() {
    progress += 1;
  }

  @action
  void createProject(BuildContext context, String title) =>
      createProjectFromScratch(title,
              host: selectHostStore.selectedHost, type: projectType)
          .then((value) => goToProject(context: context, instance: value));
}
