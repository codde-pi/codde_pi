import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class ControlledDeviceDialog extends StatelessWidget {
  final bool requireHost;
  final Device? existingDevice;
  const ControlledDeviceDialog(
      {super.key, this.existingDevice, this.requireHost = false});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: existingDevice != null
                ? Text(existingDevice!.name)
                : const Text("New device")),
        body: ControlledDeviceForm(
          existingDevice: existingDevice,
          cancel: () => Navigator.pop(context),
          validate: (Device device) {
            // createDevice(device);
            Navigator.of(context).pop(device);
          },
          requireHost: requireHost,
        ),
      ),
    );
  }

  /* void createDevice(Device device) {
    Hive.box<Device>('devices').add(device);
  } */
}
