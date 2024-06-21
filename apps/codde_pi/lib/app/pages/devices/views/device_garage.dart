import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/app/pages/devices/views/device_playground.dart';
import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/utils/host_details.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeviceGarage extends StatefulWidget {
  DeviceGarage({Key? key, required this.deviceKey}) : super(key: key);
  final int deviceKey;

  @override
  State<StatefulWidget> createState() {
    return _DeviceGarage();
  }
}

class _DeviceGarage extends State<DeviceGarage> {
  late Device device;
  @override
  void initState() {
    device = Hive.box<Device>("devices").get(widget.deviceKey)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicBarScaffold(
      pages: [
        // TODO: add overview page, with button at top redirecting to project list
        DynamicBarMenuItem(
          destination: DynamicBarPager.projectsList,
          widget: DeviceGarageView(device: device),
        ),
        DynamicBarMenuItem(
          destination: DynamicBarPager.diagram,
          widget: CoddeDiagram(),
        ),
      ],
      fab: DynamicFab(
        iconData: Icons.edit,
        action: () async => editDevice(),
      ),
      section: DynamicBarPager.deviceGarage,
    );
  }

  Future editDevice() async {
    return await showDialog(
        context: context,
        builder: (context) => ControlledDeviceDialog(
              existingDevice: device,
              requireHost: device.isSBC,
            )).then((value) async {
      print('res $value');
      if (value != null) {
        print('host ${value.host}');
        await Hive.box<Device>("devices")
            .put(widget.deviceKey, value)
            .then((value) => setState(() {
                  device = Hive.box<Device>("devices").get(widget.deviceKey)!;
                  print('set state');
                }));
      }
    });
  }
}

class DeviceGarageView extends StatelessWidget {
  final Device device;
  late List<Widget> carouselItems;
  DeviceGarageView({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    carouselItems = [
      device.imagePath == null
          ? Image.asset(
              noImageAsset,
              width: getSize(context).width,
            )
          : Image.file(File(device.imagePath!), width: getSize(context).width),
      Container(
          color: Theme.of(context).disabledColor,
          height: getSize(context).width * (2 / 3),
          child: const Center(child: Text('No diagram preview')))
    ];
    final projectBox = Hive.box<Project>(projectsBox);
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: projectBox.listenable(
            keys: projectBox.values
                .where((element) => element.device.key == device.key)
                .toList()),
        builder: (context, box, _) => Padding(
          padding: const EdgeInsets.all(widgetGutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: widgetGutter,
              ),
              CarouselSlider(
                items: carouselItems,
                options: CarouselOptions(
                    height: getSize(context).width * (2 / 3), padEnds: false),
              ),
              const SizedBox(height: widgetGutter),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('DEVICE MODEL'),
                Text(device.model.toString())
              ]),
              const SizedBox(height: widgetGutter),
              Text(
                "Hosting",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: widgetGutter),
              HostDetails(host: device.host),
              const SizedBox(
                height: widgetGutter,
              ),
              Text(
                "Related projects",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: widgetGutter,
              ),
              ...box.values.isEmpty
                  ? [
                      const Center(
                        child: Text(
                            "You haven't created any projects on this device. Go to `Projects` section to create one"),
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () => selectSection(context, 0),
                              child: const Text('Go To Projects ->')))
                    ]
                  : [
                      ...box.values.map(
                        (e) => InkWell(
                          onTap: () {
                            addStep(
                                context,
                                DevicePlayground(
                                  project: e,
                                ));
                            moveStepForward(
                                context, DynamicBarPager.devicePlayground);
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
    );
  }
}
