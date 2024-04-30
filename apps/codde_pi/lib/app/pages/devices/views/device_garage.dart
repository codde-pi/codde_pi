import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/app/pages/devices/views/device_playground.dart';
import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/project_launcher/project_launcher.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeviceGarage extends DynamicBarWidget {
  DeviceGarage({Key? key, required this.device}) : super(key: key);

  late CoddeDiagram diagramEditor = CoddeDiagram();

  final Device device;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final projectBox = Hive.box<Project>(projectsBox);
    return Scaffold(
      appBar: AppBar(title: Text(device.name)),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: projectBox.listenable(
              keys: projectBox.values
                  .where((element) => element.device.key == device.key)
                  .toList()),
          builder: (context, box, widget) => Padding(
            padding: const EdgeInsets.all(widgetGutter),
            child: Column(
              children: [
                Container(
                    color: Theme.of(context).disabledColor,
                    height: getSize(context).width * (2 / 3),
                    child: const Center(child: Text('No diagram preview'))),
                const SizedBox(height: widgetGutter),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('DEVICE MODEL'),
                      Text(device.model.toString())
                    ]),
                const SizedBox(height: widgetGutter),
                ...box.values.isEmpty
                    ? [
                        const Center(
                          child: Text(
                              "You haven't created any projects on this device. Go to `Projects` section to create one"),
                        ),
                        Center(
                            child: TextButton(
                                onPressed: () =>
                                    bar.setPage(bar.destinations[0]),
                                child: const Text('Go To Projects ->')))
                      ]
                    : [
                        ...box.values.map(
                          (e) => InkWell(
                            onTap: () {
                              bar.selectBreadcrumbTab(bar.breadCrumbTabs[2],
                                  widget: DevicePlayground(
                                    project: e,
                                  ));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(widgetGutter / 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(height: widgetGutter / 2),
                                      Text(e.device.host?.pushDir ??
                                          'no remote location'),
                                      // TODO: text span "description"
                                      Text(e.description ?? ''),
                                    ]),
                              ),
                            ),
                          ),
                          /* title: Text(e.name),
                            onTap: (device) {
                              bar.selectBreadcrumbTab(bar.breadCrumbTabs[2],
                                  widget: DevicePlayground(
                                    project: e,
                                  ));
                            },
                            subtitle: Text(e.description ?? '')), */
                        ),
                        /* const SizedBox(height: widgetGutter),
                       OutlinedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProjectLauncher())),
                        child: const Text("NEW PROJECT"),
                      ), */
                      ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  List<DynamicBarMenuItem>? get bottomMenu => [
        DynamicBarMenuItem(
            name: "Projects list",
            iconData: Icons.gamepad,
            destination: DynamicBarDestination(
                widget: () => this,
                index: 0,
                iconData: Icons.settings,
                name: "Garage")),
        DynamicBarMenuItem(
          name: "Diagram editor",
          iconData: Icons.cable,
          destination:
              DynamicBarPager.deviceDiagramEditor(instance: diagramEditor),
        ),
      ];

  @override
  void setFab(BuildContext context) {
    bar.disableFab();
  }

  void updateMenu(context, int index) {
    print('menu $index');
  }

  @override
  void setIndexer(BuildContext context) {
    bar.setIndexer((p0) => updateMenu(context, p0));
  }
}
