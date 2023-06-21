import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProjectPathType { file, folder }

class FileOrFolderStep extends StatelessWidget {
  ValueNotifier<ProjectPathType> pathType =
      ValueNotifier(ProjectPathType.folder);

  FileOrFolderStep({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pathType,
      builder: (context, value, child) => Column(
        children: <Widget>[
          ListTile(
            title:
                const Text('Open C.O.D.D.E. Pi project and/or Python package'),
            leading: Radio<ProjectPathType>(
              value: ProjectPathType.folder,
              groupValue: pathType.value,
              onChanged: (ProjectPathType? value) {
                pathType.value = value!;
              },
            ),
          ),
          ListTile(
            title: const Text('Open python executable'),
            leading: Radio<ProjectPathType>(
              value: ProjectPathType.file,
              groupValue: pathType.value,
              onChanged: (ProjectPathType? value) {
                pathType.value = value!;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () => context
                  .read<ProjectLauncherCubit>()
                  .feedData({"pathType": pathType.value}),
              child: const Text('Open'))
        ],
      ),
    );
  }
}
