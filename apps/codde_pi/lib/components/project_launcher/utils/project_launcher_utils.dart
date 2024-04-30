import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void goToProject(
    {required BuildContext context, required Project instance}) async {
  /* if (GetIt.I.isRegistered<NavigationBarState>()) {
    final bar = GetIt.I.get<NavigationBarState>();
    bar.goIntoProject();
  } */
  Navigator.pushReplacementNamed(context, '/codde', arguments: instance);
}

/// Create Project
/// if [demo], create default python and controller files
Future<Project> createBackendProject(context,
    {required Project instance,
    bool demo = false,
    bool keepBackendInstance = false}) async {
  CoddeBackend backend = CoddeBackend(BackendLocation.local);
  await backend.open();
  await backend.mkdir(instance.workDir);
  GetIt.I.registerSingleton(backend);
  if (demo) {
    await backend.create(join(instance.workDir, "main.py"),
        content:
            await rootBundle.loadString("assets/samples/socketio/main.py"));
  }
  await createControllerMap(context, getControllerName(path: instance.workDir));
  await Hive.box<Project>(projectsBox).add(instance);
  if (!keepBackendInstance) {
    backend
        .close(); // TODO: good idea (to close) or not ? Need to re-open just after when loading project, but conditional
    GetIt.I.unregister<CoddeBackend>();
  }
  return instance;
}

/// Create project installlocally
Future<Project> createProjectFromScratch(context, String name,
    {required Device device,
    bool keepBackendInstance = false,
    bool demo = true}) async {
  final project = Project(
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      name: name,
      device: device,
      workDir: await getApplicationSupportDirectory()
          .then((value) => join(value.path, name)));
  return createBackendProject(context,
      instance: project, demo: demo, keepBackendInstance: keepBackendInstance);
}

void launchProject(BuildContext context, Project e) {
  /* if (GetIt.I.isRegistered<NavigationBarState>()) {
    final bar = GetIt.I.get<NavigationBarState>();
    bar.goIntoProject();
  } */
  Navigator.pushNamed(context, '/codde', arguments: e);
}
