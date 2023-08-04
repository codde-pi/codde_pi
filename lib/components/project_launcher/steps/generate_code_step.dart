import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/project_location_step.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

class GenerateCodeStep extends StatelessWidget {
  final progress = ValueNotifier(0.0);
  late CoddeBackend backend;

  Future<bool> generateCode(ProjectType projectType,
      ProjectLocationType location, Project project) async {
    late BackendLocation backendLocation;
    if (location != ProjectLocationType.ssh) {
      backendLocation = BackendLocation.local;
    } else {
      /* final sshClient = SSHClient(
          await SSHSocket.connect(project.host!.ip, project.host!.port!),
          username: project.host!.user,
          onPasswordRequest: () => project.host!.pswd);
      final sftp = await sshClient.sftp();
      sftp.mkdir(project.path); */
      backendLocation = BackendLocation.server;
    }
    backend = CoddeBackend(backendLocation,
        credentials: SFTPCredentials(
            host: project.host!.addr,
            port: project.host!.port!,
            pswd: project.host!.pswd,
            user: project.host!.user));
    await backend.open();
    await backend.mkdir(project.path);

    switch (projectType) {
      case ProjectType.codde_pi || ProjectType.controller:
        String com = 'socketio';
        if (project.controlledDevice != null) {
          com = project.controlledDevice!.protocol.name;
        }
        progress.value = 25.0;

        final controller =
            await rootBundle.loadString('assets/samples/$com/controller.tmx');
        progress.value = 35.0;
        generateFile(
            path: project.path, name: 'controller.tmx', content: controller);
        progress.value = 50.0;

        if (projectType == ProjectType.codde_pi) {
          final main =
              await rootBundle.loadString('assets/samples/$com/main.py');
          progress.value = 60.0;
          generateFile(path: project.path, name: 'main.py', content: main);
          // TODO: pyproject.toml
        }
        progress.value = 85.0;
        break;
      case ProjectType.executable:
        String content =
            await rootBundle.loadString('assets/samples/executable.py');
        progress.value = 50.0;
        await generateFile(
            path: project.path,
            name: '${project.name.toLowerCase().replaceAll(' ', '_')}.py',
            content: content);
        progress.value = 75.0;
        break;
      default: // empty, package
        break;
    }
    var file = await generateFile(
        path: project.path,
        name: 'README.md',
        content: project.description ?? '');
    progress.value = 100.0;
    // TODO: return file.exists();
    return true;
  }

  Future<FileEntity> generateFile(
      {required String path,
      required String name,
      required String content}) async {
    return backend.save(join(path, name), content);
  }

  @override
  Widget build(BuildContext context) {
    final codeToGenerate = context.read<ProjectLauncherCubit>();
    return FutureBuilder(
        future: generateCode(codeToGenerate.state.projectType,
            codeToGenerate.state.projectLocation, codeToGenerate.state.data),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            GetIt.I.registerLazySingleton(() => backend);
            Hive.box<Project>(projectsBox).add(codeToGenerate.state.data);
            context.read<ProjectLauncherCubit>().launchProject();
          }
          return ValueListenableBuilder(
              valueListenable: progress,
              builder: (_, __, ___) => Center(
                  child: LinearProgressIndicator(value: progress.value)));
        });
  }
}
