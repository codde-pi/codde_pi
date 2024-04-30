import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/project/store/project_store.dart';
import 'package:codde_pi/components/dialogs/create_project_dialog.dart'
    as dialog;
import 'package:codde_pi/components/dialogs/select_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/components/project_launcher/utils/project_launcher_utils.dart';
import 'package:codde_pi/components/project_picker/project_picker.dart';
import 'package:codde_pi/components/projects_carousel/projects_carousel.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;

class GlobalProjects extends DynamicBarWidget {
  GlobalProjects({super.key});
  final ProjectStore store = ProjectStore();
  final pageController = PageController();

  @override
  setFab(context) {
    bar.setFab(
        iconData: Icons.add,
        action: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProjectLauncher()),
            ));
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

  Future openProject(
      BuildContext context, dialog.ProjectLocationType projectLocType) async {
    String? path;
    Device? device;
    if (projectLocType == dialog.ProjectLocationType.usb) {
      return;
    } else if (projectLocType == dialog.ProjectLocationType.internal) {
      path = await FilePicker.platform
          .getDirectoryPath(dialogTitle: "Select Project");
    } else if (projectLocType == dialog.ProjectLocationType.ssh) {
      device = await showDialog(
          context: context,
          builder: (context) => SelectDeviceDialog(onlyHosts: true));
      if (device != null && device.host != null) {
        path = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProjectPicker(home: getUserHome(device!.host!.user))));
        if (path != null) {
          final pjt = await addExistingProject(context, p.basename(path),
              path: path, device: device);
          Navigator.of(context).pushReplacementNamed('/codde', arguments: pjt);
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to pick remote project")));
        }
      }
    }
    if (path != null && device != null) {
      try {
        Project existingProject = Hive.box<Project>(projectsBox)
            .values
            .singleWhere((e) => e.workDir == path && e.device == device);
        launchProject(context, existingProject);
      } catch (e) {
        Project p = Project(
            name: basenameWithoutExtension(path),
            device: device,
            workDir: path,
            dateCreated: DateTime.now(),
            dateModified: DateTime.now());
        Hive.box<Project>(projectsBox).add(p);
        launchProject(context, p);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final NavigationBarState bar = GetIt.I.get<NavigationBarState>();
    // if (bar.destinations[bar.currentPage].widget.runtimeType == runtimeType) {}
    store.refreshProjects(context);

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings))
        ]),
        body: GestureDetector(
          onPanUpdate: (details) =>
              (details.delta.dx < 0) ? unfoldProjectsList(context) : null,
          child: Padding(
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
                // TODO: Add section "import project" only select projects with .coddepi-workspace file ?
                SliverList.list(children: [
                  const SizedBox(height: widgetSpace),
                  CoddeTile(
                    leading: const Icon(Icons.file_open),
                    title: const Text('Open...'),
                    onTap: () async {
                      final dialog.ProjectLocationType projectLocType =
                          await showDialog(
                              context: context,
                              builder: (context) =>
                                  dialog.openProjectDialog(context));
                      openProject(context, projectLocType);
                    },
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
                                        builder: (context) =>
                                            ProjectLauncher()),
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
      ),
    );
  }

  @override
  void setIndexer(context) {
    bar.setIndexer((p0) => p0 == 0 ? print('O') : print('1'));
  }

  @override
  get bottomMenu => [
        DynamicBarMenuItem(name: "test0", iconData: Icons.numbers),
        DynamicBarMenuItem(name: "test2", iconData: Icons.numbers)
      ];
}
