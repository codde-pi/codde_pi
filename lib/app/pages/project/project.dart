import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/components/project_launcher/models/project_launcher_scenarii.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GlobalProjects extends StatelessWidget {
  const GlobalProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final DynamicBarState bar = GetIt.I.get<DynamicBarState>();
    bar.setFab(
      iconData: Icons.add,
      action: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProjectLauncher(steps: ProjectLauncherScenarii.newProject),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                onTap: () async => await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectLauncher(
                            steps: ProjectLauncherScenarii.recentProjects)))),
            ListTile(
              title: Text("Pick from storage"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectLauncher(
                          steps: ProjectLauncherScenarii.openPath))),
            ),
            ListTile(
              title: Text("Pick from RPI"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectLauncher(
                          steps: ProjectLauncherScenarii.openRemotePath))),
            ),
            /* SizedBox(
              height: 24.0,
            ),
            ListTile(
                tileColor: cddTheme.highlightColor,
                onTap: () => Get.to(() =>
                    ProjectLauncher(steps: ProjectLauncherScenarii.newProject)),
                title: Text(
                  "New project",
                )), */
          ],
        ),
      ),
    );
  }
}
