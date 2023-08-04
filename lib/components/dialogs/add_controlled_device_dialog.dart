import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/widgets.dart';

class NewControlledDeviceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledDeviceForm(
      cancel: () => Navigator.pop(context),
      validate: (Device device) => Navigator.pop(context, device),
    );
  }
}
