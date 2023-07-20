import 'package:codde_pi/components/dialogs/project_location_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/components/project_launcher/models/project_launcher_scenarii.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class GlobalProjects extends StatelessWidget {
  const GlobalProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final DynamicBarState bar = GetIt.I.get<DynamicBarState>();
    if (bar.destinations[bar.currentPage].widget.runtimeType ==
        this.runtimeType) {
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
    }
    final Iterable recentHosts = Hive.box<Host>('hosts').values.take(6).map(
          (e) => Card(
              child: ListTile(
            title: Text(e.name),
            subtitle: Text(e.ip),
            onTap: () {/* TODO */},
          )),
        );
    final Iterable recentProjects = Hive.box<Project>(projectsBox)
        .values
        .take(2)
        .map(
          (e) => Card(
              child: ListTile(
            title: Text(e.name),
            subtitle: Text('Last modified: ${e.dateModified}'),
            onTap: () => Navigator.pushNamed(context, '/codde', arguments: e),
          )),
        );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(widgetGutter),
        child: CustomScrollView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height / 3,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Projects",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            SliverList.list(children: [
              const SizedBox(height: widgetSpace),
              Card(
                child: ListTile(
                  selected: true,
                  title: const Text('Open...'),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ProjectLocationDialog(
                      navigateLocal: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectLauncher(
                              steps: ProjectLauncherScenarii.openPath),
                        ),
                      ),
                      navigateRemote: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectLauncher(
                              steps: ProjectLauncherScenarii.openRemotePath),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: widgetSpace),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recents",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Tooltip(
                    showDuration: Duration(seconds: 1),
                    triggerMode: TooltipTriggerMode.tap,
                    message:
                        'CODDE Pi projects explaination. See oneline doc for more info',
                    child: Icon(Icons.help),
                  ),
                ],
              ),
              ...recentProjects.isEmpty
                  ? [
                      Center(
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectLauncher(
                                        steps:
                                            ProjectLauncherScenarii.newProject),
                                  ),
                                ),
                            child: const Text('New Project')),
                      ),
                    ]
                  : recentProjects,
              Align(
                alignment: Alignment.topLeft,
                child: OutlinedButton(
                    onPressed: () {/* TODO  */}, child: const Text('Show All')),
              ),
              const SizedBox(height: widgetSpace),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hosts",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Tooltip(
                    showDuration: Duration(seconds: 1),
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'Host explaination. See oneline doc for more info',
                    child: Icon(Icons.help),
                  ),
                ],
              ),
              ...recentHosts.isEmpty
                  ? [
                      Center(
                        child: ElevatedButton(
                            onPressed: () {/* TODO: */},
                            child: const Text('New Host')),
                      )
                    ]
                  : recentHosts,
              Align(
                alignment: Alignment.topLeft,
                child: OutlinedButton(
                    onPressed: () {/* TODO:  */},
                    child: const Text('Show All')),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
