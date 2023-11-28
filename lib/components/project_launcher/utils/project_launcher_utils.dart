import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/project_type.dart';
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
    {required Project instance, bool demo = false}) async {
  CoddeBackend backend = instance.host != null
      ? CoddeBackend(BackendLocation.server,
          credentials: instance.host!.toCredentials())
      : CoddeBackend(BackendLocation.local);
  backend.open();
  await backend.mkdir(instance.path);
  GetIt.I.registerSingleton(backend);
  if (demo) {
    backend.create(join(instance.path, "main.py"),
        content:
            await rootBundle.loadString("assets/samples/socketio/main.py"));
  }
  createControllerMap(context, getControllerName(instance.path))
      .then((_) => Hive.box<Project>(projectsBox).add(instance));
  backend.close();
  return instance;
}

/// Create project installlocally
Future<Project> createProjectFromScratch(context, String name,
    {ProjectType? type, Host? host}) async {
  final project = Project(
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      name: name,
      type: type ?? ProjectType.controller,
      host: host,
      path: host == null
          ? await getApplicationSupportDirectory()
              .then((value) => join(value.path, name))
          : join(
              "~", name)); // TODO: add field in form to customize project path
  return createBackendProject(context,
      instance: project, demo: type == ProjectType.codde_pi);
}

void launchProject(BuildContext context, Project e) {
  /* if (GetIt.I.isRegistered<NavigationBarState>()) {
    final bar = GetIt.I.get<NavigationBarState>();
    bar.goIntoProject();
  } */
  Navigator.pushNamed(context, '/codde', arguments: e);
}
