import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProjectType { codde_pi, controller, package, executable, empty }

class ChooseProjectTypeStep extends StatelessWidget {
  final projectType = ValueNotifier(ProjectType.codde_pi);

  ChooseProjectTypeStep({super.key});

  void select(BuildContext context, ProjectType? value,
      {bool jumpNextStep = false}) {
    projectType.value = value!;
    context.read<ProjectLauncherCubit>().defineProjectType(value);
    context.read<ProjectLauncherCubit>().nextPage(offset: jumpNextStep ? 2 : 1);
    // whether to skip the "device to control" configuration
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Radio(
              value: ProjectType.codde_pi,
              groupValue: projectType.value,
              onChanged: (value) {
                select(context, value);
              }),
          title: const Text("C.O.D.D.E. Pi project"),
          trailing: const Icon(Icons.question_mark),
        ),
        ListTile(
          leading: Radio(
              value: ProjectType.controller,
              groupValue: projectType.value,
              onChanged: (value) {
                select(context, value);
              }),
          title: const Text("Remote controller"),
          trailing: const Icon(Icons.question_mark),
        ),
        /*TODO:  ListTile(
          leading: Radio(
              value: ProjectType.package,
              groupValue: projectType.value,
              onChanged: (value) => select(context, value, jumpNextStep: true)),
          title: const Text("Python package"),
          trailing: const Icon(Icons.question_mark),
        ), */
        ListTile(
          leading: Radio(
              value: ProjectType.executable,
              groupValue: projectType.value,
              onChanged: (value) => select(context, value, jumpNextStep: true)),
          title: const Text("Python executable file"),
          trailing: const Icon(Icons.question_mark),
        ),
        ListTile(
          leading: Radio(
              value: ProjectType.empty,
              groupValue: projectType.value,
              onChanged: (value) => select(context, value)),
          title: const Text("Create your project from scratch"),
          trailing: const Icon(Icons.question_mark),
        ),
      ],
    );
  }
}
