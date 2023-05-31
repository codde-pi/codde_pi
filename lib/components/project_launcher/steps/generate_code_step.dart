import 'dart:io';

import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

class GenerateCodeStep extends StatelessWidget {
  Future<bool> generateCode(ProjectType projectType, Project project) async {
    switch (projectType) {
      case ProjectType.codde_pi || ProjectType.controller:
        String com = 'socketio';
        if (project.controlledDevice != null) {
          com = project.controlledDevice!.protocol.name;
        }

        final controller =
            await rootBundle.loadString('assets/samples/$com/controller.tmx');
        generateFile(
            path: project.path, name: 'controller.tmx', content: controller);

        if (projectType == ProjectType.codde_pi) {
          final main =
              await rootBundle.loadString('assets/samples/$com/main.py');
          generateFile(path: project.path, name: 'main.py', content: main);
          // TODO: pyproject.toml
        }
        break;
      case ProjectType.executable:
        String content =
            await rootBundle.loadString('assets/samples/executable.py');
        await generateFile(
            path: project.path,
            name: '${project.name.toLowerCase().replaceAll(' ', '_')}.py',
            content: content);
        break;
      default: // empty, package
        break;
    }
    await generateFile(
        path: project.path,
        name: 'README.md',
        content: project.description ?? '');
    return true;
  }

  Future<File> generateFile(
      {required String path,
      required String name,
      required String content}) async {
    File f = File(join(path, name));
    return f.writeAsString(content);
  }

  @override
  Widget build(BuildContext context) {
    final codeToGenerate = context.watch<ProjectLauncherCubit>();
    return FutureBuilder(
        future: generateCode(
            codeToGenerate.state.projectType, codeToGenerate.state.data),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            Hive.box<Project>(projectsBox).add(codeToGenerate.state.data);
            context.read<ProjectLauncherCubit>().launchProject();
          }
          return const Center(child: LinearProgressIndicator());
        });
  }
}
