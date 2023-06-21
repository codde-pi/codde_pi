import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class OpenPathStep extends StatelessWidget {
  const OpenPathStep({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FilePicker.platform.getDirectoryPath(),
        builder: (context, AsyncSnapshot<String?> state) {
          if (state.connectionState != ConnectionState.done) {
            return const Center(child: LinearProgressIndicator()); // never used
          }
          if (state.data != null) {
            /* context.read<ProjectLauncherCubit>().feedData({"path": state});
          final data = context.select((ProjectLauncherCubit bloc) => bloc.state.data); */
            final box = Hive.box<Project>(projectsBox);
            final projects = box.values.where((element) =>
                element.path == state.data && element.host == null);
            // TODO: if (projects.length > 1) { /* let user choose which one */}
            if (projects.isEmpty) {
              final created = Project(
                dateCreated: DateTime.now(),
                dateModified: DateTime.now(),
                path: state.data!,
                name: state.data!.split('/').last.replaceAll('.py', ''),
              ); // unused if only folders are selected
              final key = box.add(created);
              context
                  .read<ProjectLauncherCubit>()
                  .launchProject(instance: created);
            } else {
              context
                  .read<ProjectLauncherCubit>()
                  .launchProject(instance: projects.first);
            }
          }

          if (state.connectionState == ConnectionState.done &&
              state.data == null) {
            Navigator.pop(context);
          }
          return Column(children: const [
            CircularProgressIndicator(),
            Text('Loading project...')
          ]);
        });
  }
}
