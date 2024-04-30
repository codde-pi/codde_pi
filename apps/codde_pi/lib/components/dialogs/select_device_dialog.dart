import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_controlled_device_dialog.dart';
import 'store/select_device_store.dart';

class SelectDeviceDialog extends StatelessWidget {
  final store = SelectDeviceStore();
  final pathController = TextEditingController();

  final bool onlyHosts;
  SelectDeviceDialog({super.key, this.onlyHosts = false});

  @override
  Widget build(BuildContext context) {
    // store.refreshDevices(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Select Device'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  if (store.selectedDevice != null) {
                    Navigator.of(context).pop(store.selectedDevice!.key);
                  } else {
                    store.raiseNoDeviceError();
                  }
                },
                child: const Text("VALIDATE"))
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Device>("devices").listenable(),
          builder: (context, box, widget) => Observer(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(widgetGutter),
              child: Column(
                children: [
                  ...box.values
                          .where((element) =>
                              onlyHosts ? element.host != null : true)
                          .isEmpty
                      ? [
                          const Center(
                              child: /* ElevatedButton(
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewControlledDeviceDialog()),
                                    ) /* .whenComplete(
                                      () => store.refreshDevices(context)) */
                                ,
                                child: const Text('New Device')), */
                                  Text('No device found'))
                        ]
                      : [
                          ...box.values
                              .where((element) =>
                                  onlyHosts ? element.host != null : true)
                              .map(
                                (e) => RadioMenuButton(
                                  value: e,
                                  groupValue: store.selectedDevice,
                                  onChanged: (host) {
                                    store.selectDevice(host!);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text("${e.protocol.name} : ${e.addr}")
                                    ],
                                  ),
                                ),
                              ),
                          OutlinedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewControlledDeviceDialog(
                                          requireHost: true,
                                        ))),
                            child: const Text("NEW DEVICE"),
                          ),
                        ],
                  if (store.noDeviceError)
                    Text(
                      'Select a host for this project',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
