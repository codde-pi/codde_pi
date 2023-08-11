import 'package:codde_pi/components/dialogs/select_device_dialog.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';

import 'store/codde_device_store.dart';
import 'views/device_details.dart';

class CoddeDeviceDialog extends StatelessWidget {
  final CoddeDeviceStore store;
  CoddeDeviceDialog({super.key, required ControllerProperties? properties})
      : store = CoddeDeviceStore(properties);
  final commandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        appBar: AppBar(
          /* leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close)), */
          title: Text("Device: ${store.props?.deviceId ?? 'None'}"),
          actions: [
            ElevatedButton(
                onPressed: store.props != null
                    ? () => Navigator.of(context).pop(store.props)
                    : null,
                child: const Text("VALIDATE"))
          ],
        ),
        body: Observer(
          builder: (context) => store.props?.deviceId == null
              ? Center(
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        final deviceId = await showDialog(
                            context: context,
                            builder: (context) => SelectDeviceDialog());
                        if (deviceId != null) {
                          store.setProps(store.props != null
                              ? store.props!.copyWith(deviceId: deviceId)
                              : ControllerProperties(deviceId: deviceId));
                        }
                      },
                      label: const Text('Select Device'),
                      icon: const Icon(Icons.add)))
              : Column(children: [
                  DeviceDetails(
                      device: Hive.box<Device>("devices")
                          .get(store.props!.deviceId)!),
                  const Text('Assign remote shell command'),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: "command (\$CWD for root project path)",
                        border: OutlineInputBorder()),
                    controller: commandController,
                    onSubmitted: (value) => store.addExecutable(value),
                  )
                ]),
        ),
      ),
    );
  }
}
