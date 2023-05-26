import 'package:codde_pi/components/dynamic_bar/cubit/dynamic_bar_cubit.dart';
import 'package:codde_pi/components/project_launcher/models/project_launcher_scenarii.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalProjects extends StatelessWidget {
  const GlobalProjects({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DynamicBarCubit>().setFab(
          Icons.add,
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ProjectLauncher(steps: ProjectLauncherScenarii.newProject),
            ),
          ),
        );
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* TextButton(
                onPressed: () => {},
                child: Text(
                  "Open recent",
                  style: cddTheme.textTheme.headlineLarge,
                )), */
            Text(
              "Open project...",
              style: cddTheme.textTheme.headlineLarge,
            ),
            ListTile(
                title: Text("Recent"),
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProjectLauncher(
                              steps: ProjectLauncherScenarii.recentProjects)),
                    )),
            ListTile(
              title: Text("Pick from storage"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProjectLauncher(
                      steps: ProjectLauncherScenarii.openPath))),
            ),
            ListTile(
              title: Text("Pick from RPI"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProjectLauncher(
                      steps: ProjectLauncherScenarii.openRemotePath))),
            ),
            SizedBox(
              height: 24.0,
            ),
            ListTile(
                tileColor: cddTheme.highlightColor,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectLauncher(
                        steps: ProjectLauncherScenarii.newProject))),
                title: Text(
                  "New project",
                )),
          ],
        ),
      ),
    );
  }
}
