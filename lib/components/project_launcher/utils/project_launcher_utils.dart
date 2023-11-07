import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/navigation_bar/navigation_bar_state.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/project_type.dart';
import 'package:flutter/material.dart';
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

Future<Project> createProject(context, {required Project instance}) async {
  CoddeBackend backend = CoddeBackend(BackendLocation.local);
  await backend.mkdir(instance.path);
  GetIt.I.registerSingleton(backend);
  createControllerMap(context, getControllerName(instance.path))
      .then((_) => Hive.box<Project>(projectsBox).add(instance));
  return instance;
}

Future<Project> createProjectFromScratch(context, String name,
    {ProjectType? type, Host? host}) async {
  final project = Project(
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      name: name,
      type: type ?? ProjectType.controller,
      host: host,
      path: await getApplicationSupportDirectory()
          .then((value) => join(value.path, name)));
  return createProject(context, instance: project);
}

void launchProject(BuildContext context, Project e) {
  /* if (GetIt.I.isRegistered<NavigationBarState>()) {
    final bar = GetIt.I.get<NavigationBarState>();
    bar.goIntoProject();
  } */
  Navigator.pushNamed(context, '/codde', arguments: e);
}
