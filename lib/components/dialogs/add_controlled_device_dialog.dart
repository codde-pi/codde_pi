import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class NewControlledDeviceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ControlledDeviceForm(
      cancel: () => Navigator.pop(context),
      validate: (Device device) {
        createDevice(device);
        Navigator.pop(context, device);
      },
    ));
  }

  void createDevice(Device device) {
    Hive.box<Device>('devices').add(device);
  }
}
