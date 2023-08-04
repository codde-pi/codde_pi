import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void goToProject(
    {required BuildContext context, required Project instance}) async {
  Navigator.pushReplacementNamed(context, '/codde', arguments: instance);
}

Project createProject({required Project instance}) {
  Hive.box<Project>(projectsBox).add(instance);
  return instance;
}

Future<Project> createProjectFromScratch(String name) async {
  final project = Project(
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      name: name,
      path: await getApplicationDocumentsDirectory()
          .then((value) => join(value.path, name)));
  return createProject(instance: project);
}
