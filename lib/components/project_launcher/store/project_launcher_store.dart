import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/file_or_folder_step.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:mobx/mobx.dart';

part 'project_launcher_store.g.dart';

class ProjectLauncherStore = _ProjectLauncherStore with _$ProjectLauncherStore;

abstract class _ProjectLauncherStore with Store {
  @observable
  ProjectType projectType = ProjectType.codde_pi;

  @observable
  ProjectPathType pathType = ProjectPathType.folder;

  @observable
  Host? selectedHost;

  @action
  setProjectType() {}
}
