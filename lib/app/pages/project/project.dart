import 'package:codde_pi/app/pages/project/store/project_store.dart';
import 'package:codde_pi/components/dialogs/create_project_dialog.dart'
    as dialog;
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/components/project_launcher/utils/project_launcher_utils.dart';
import 'package:codde_pi/components/projects_carousel/projects_carousel.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';

class GlobalProjects extends DynamicBarWidget {
  GlobalProjects({super.key});
  final ProjectStore store = ProjectStore();
  final pageController = PageController();

  @override
  setFab(context) {
    print('PROJECT setFAB');
    bar.setFab(
        iconData: Icons.add,
        action: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProjectLauncher()),
            ));
    print("is FAB ? ${bar.fab != null}");
  }

  Route<Project?> _projectListRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProjectsCarousel(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<Project?> unfoldProjectsList(BuildContext context) async {
    return await Navigator.of(context).push<Project?>(_projectListRoute());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final NavigationBarState bar = GetIt.I.get<NavigationBarState>();
    // if (bar.destinations[bar.currentPage].widget.runtimeType == runtimeType) {}
    store.refreshProjects(context);
    store.refreshHosts(context);

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings))
        ]),
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
                CoddeTile(
                  leading: const Icon(Icons.file_open),
                  title: const Text('Open...'),
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => dialog.openProjectDialog(context)),
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
                const SizedBox(height: widgetSpace),
                Hive.box<Project>(projectsBox).values.isEmpty
                    ? Center(
                        child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProjectLauncher()),
                                ),
                            child: const Text('New Project')),
                      )
                    : CoddeTile(
                        selected: true,
                        title: const Text('All projects'),
                        onTap: () async {
                          final Project? project =
                              await unfoldProjectsList(context);
                          if (project != null) {
                            launchProject(context, project);
                          }
                        },
                        tailing: const Icon(Icons.arrow_right)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
