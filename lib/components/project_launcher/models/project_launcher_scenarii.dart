import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/introduce_project_step.dart';
import 'package:codde_pi/components/project_launcher/steps/open_path_step.dart';
import 'package:codde_pi/components/project_launcher/steps/project_location_step.dart';
import 'package:codde_pi/components/project_launcher/steps/recent_project_step.dart';
import 'package:codde_pi/components/project_launcher/steps/target_device_step.dart';
import 'package:flutter/material.dart';

class ProjectLauncherScenarii {
  static final List<Widget> recentProjects = [RecentProjectStep()];
  static const List<Widget> openPath = [OpenPathStep()];
  static final List<Widget> openRemotePath = [];
  static final List<Widget> newProject = [
    IntroduceProjectStep(),
    ChooseProjectTypeStep(),
    ProjectLocationStep(),
    TargetDeviceStep(),
  ];
}
