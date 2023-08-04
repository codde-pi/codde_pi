import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/project_location_step.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_launcher_state.freezed.dart';

@freezed
class ProjectLauncherState with _$ProjectLauncherState {
  const factory ProjectLauncherState(
          {@Default(0) int currentPage,
          required Project data,
          Project? projectInstance,
          @Default(ProjectLocationType.internal)
          ProjectLocationType projectLocation,
          @Default(ProjectType.codde_pi) ProjectType projectType}) =
      _ProjectLauncherState;
}
