import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_state.dart';
import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/project_location_step.dart';
import 'package:codde_pi/services/db/project.dart';

class ProjectLauncherCubit extends Cubit<ProjectLauncherState> {
  ProjectLauncherCubit()
      : super(ProjectLauncherState(
            data: Project(
                dateCreated: DateTime.now(),
                dateModified: DateTime.now(),
                name: '',
                path: '')));

  void launchProject({Project? instance}) {
    emit(state.copyWith(projectInstance: instance ?? state.data));
  }

  feedData(Map<String, Object?> data, {bool nextPage = false}) {
    emit(state.copyWith(
        data: state.data != null
            ? state.data!.copyWithJson(data)
            : Project.fromJson(data)));
    if (nextPage) {
      this.nextPage();
    }
  }

  void defineProjectType(ProjectType value) {
    emit(state.copyWith(projectType: value));
  }

  void nextPage({int offset = 1}) {
    // TODO: add security, launchProject if max index is covered ?
    emit(state.copyWith(currentPage: state.currentPage + offset));
  }

  void previousPage({int offset = 1}) {
    emit(state.copyWith(currentPage: max(0, state.currentPage - offset)));
  }

  void setLocation(ProjectLocationType location) {
    emit(state.copyWith(projectLocation: location));
  }
}
