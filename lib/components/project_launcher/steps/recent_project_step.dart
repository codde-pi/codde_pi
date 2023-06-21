import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/components/project_launcher/models/project_instance_tile.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentProjectStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Project>(projectsBox).listenable(),
        builder: (context, box, widget) {
          final objects = box.values.whereType<Project>();
          objects
              .toList()
              .sort((a, b) => b.dateModified.compareTo(a.dateModified));
          return objects.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: objects.length,
                  // Generate 100 widgets that display their index in the List.
                  itemBuilder: (BuildContext context, int index) =>
                      ProjectInstanceTile(
                          project: objects.elementAt(index),
                          select: selectProject),
                )
              : Center(
                  child: FloatingActionButton.extended(
                  onPressed:
                      () {}, //=> Navigator.push(context, NewP(Project)), // Routes
                  icon: const Icon(Icons.add),
                  label: const Text("NEW PROJECT"),
                ));
        });
  }

  void selectProject(BuildContext context, Project instance) {
    context.read<ProjectLauncherCubit>().launchProject(instance: instance);
  }
}
