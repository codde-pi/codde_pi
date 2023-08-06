import 'package:codde_pi/app/pages/project/store/project_store.dart';
import 'package:codde_pi/components/dialogs/create_project_dialog.dart';
import 'package:codde_pi/components/dialogs/new_host_dialog.dart';
import 'package:codde_pi/components/dialogs/project_location_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/components/project_launcher/models/project_launcher_scenarii.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class GlobalProjects extends DynamicBarWidget {
  GlobalProjects({super.key});
  final ProjectStore store = ProjectStore();

  @override
  setFab(context) {
    bar.setFab(
      iconData: Icons.add,
      action: () => showDialog(
        context: context,
        builder: (context) => CreateProjectDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DynamicBarState bar = GetIt.I.get<DynamicBarState>();
    if (bar.destinations[bar.currentPage].widget.runtimeType == runtimeType) {}
    store.refreshProjects(context);
    store.refreshHosts(context);

    return Observer(
      builder: (_) => Scaffold(
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
              // Recent projects list
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
                ...store.recentProjects.isEmpty
                    ? [
                        Center(
                          child: ElevatedButton(
                              onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => CreateProjectDialog(),
                                  ),
                              child: const Text('New Project')),
                        ),
                      ]
                    : store.recentProjects.toList(),
                Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                      onPressed: () {
                        store.allProjects();
                        store.refreshProjects(context);
                      },
                      child: const Text('Show All')),
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
                      message:
                          'Host explaination. See oneline doc for more info',
                      child: Icon(Icons.help),
                    ),
                  ],
                ),
                ...store.recentHosts.isEmpty
                    ? [
                        Center(
                          child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewHostDialog()),
                                  ).whenComplete(
                                      () => store.refreshHosts(context)),
                              child: const Text('New Host')),
                        )
                      ]
                    : store.recentHosts.toList(),
                Row(
                    mainAxisAlignment: (store.recentHosts.isNotEmpty)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            store.allHosts();
                            store.refreshHosts(context);
                          },
                          child: const Text('Show All')),
                      if (store.recentHosts.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewHostDialog()),
                          ).whenComplete(() => store.refreshHosts(context)),
                        )
                    ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
