import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class NewControlledDeviceDialog extends StatelessWidget {
  final bool requireHost;
  const NewControlledDeviceDialog({super.key, this.requireHost = false});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("New device")),
        body: ControlledDeviceForm(
          cancel: () => Navigator.pop(context),
          validate: (Device device) {
            // createDevice(device);
            Navigator.pop(context, device);
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
