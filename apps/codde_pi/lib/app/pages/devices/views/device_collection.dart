import 'dart:io';

import 'package:codde_pi/app/pages/devices/models/device_step.dart';
import 'package:codde_pi/app/pages/devices/views/device_garage.dart';
import 'package:codde_pi/app/pages/devices/views/device_playground.dart';
import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/components/views/image_tile.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeviceCollection extends DynamicBarStatefulWidget {
  @override
  DynamicBarState<DynamicBarStatefulWidget> createDynamicState() {
    return _DeviceCollection();
  }
}

class _DeviceCollection extends DynamicBarState<DeviceCollection> {
  late DynamicBarStore bar = GetIt.I.get<DynamicBarStore>();
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Device>("devices").listenable(),
        builder: (context, box, widget) => Padding(
          padding:
              const EdgeInsets.only(left: widgetGutter, right: widgetGutter),
          child: box.values.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Devices',
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(
                        height: 48.0,
                      ),
                      Text('No Device found. Please regsiter one.'),
                      const SizedBox(height: 48.0),
                      FloatingActionButton.extended(
                        onPressed: () async {
                          final res = await showDialog(
                              context: context,
                              builder: (context) =>
                                  const ControlledDeviceDialog());
                          if (res != null) {
                            Hive.box<Device>("devices").add(res);
                          }
                        },
                        label: const Text("NEW DEVICE"),
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                )
              // TODO: Add option to change view to StaggeredGrid
              : Column(
                  children: [
                    // TODO: breadcrumb
                    // TODO: title

                    ...box.values.map(
                      (e) => ImageTile(
                          leading: e.imagePath,
                          title: Text(e.name),
                          onTap: () {
                            // bar.setBreadcrumbTabArg(e);
                            bar.selectBreadcrumbTab(bar.breadCrumbTabs[1],
                                widget: DeviceGarage(
                                  deviceKey: e.key,
                                ));
                          },
                          subtitle: Text("${e.protocol.name} : ${e.addr}")),
                    ),
                    /* const SizedBox(height: widgetGutter),
                    OutlinedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ControlledDeviceDialog())),
                      child: const Text("NEW DEVICE"),
                    ), */
                  ],
                ),
        ),
      ),
    );
  }

  @override
  List<DynamicBarMenuItem>? get bottomMenu => [
        DynamicBarMenuItem(name: "Personal", iconData: Icons.home),
        DynamicBarMenuItem(name: "Community", iconData: Icons.language),
        DynamicBarMenuItem(name: "Brands", iconData: Icons.toys)
      ];

  @override
  void setFab(BuildContext context) {
    bar.setFab(
        iconData: Icons.add,
        action: () async => showDialog(
                    context: context,
                    builder: (context) => const ControlledDeviceDialog())
                .then((value) {
              if (value != null) Hive.box<Device>("devices").add(value);
            }));
  }

  @override
  void setIndexer(BuildContext context) {
    /* indexer: (p0) {
          switch (p0) {
            case 0:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewControlledDeviceDialog()));
            default:
              Navigator.of(context).pushReplacementNamed('/');
          }
        },
*/
  }
}
