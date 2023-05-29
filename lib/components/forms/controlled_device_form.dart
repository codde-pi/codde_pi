import 'package:codde_pi/components/utils/ip_device_finder.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ControlledDeviceForm extends StatelessWidget {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final protocol = ValueNotifier(DeviceProtocol.socketio);
  final model = ValueNotifier(DeviceModel.sbc);

  final Function cancel;
  final Function validate;

  void getAddress() async {
    addressController.text = await Get.dialog(const IpDeviceFinder()) ?? '';
  }

  ControlledDeviceForm(
      {super.key, required this.cancel, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: "name"),
          controller: nameController,
        ),
        Row(
          children: [
            Text("Choose your board:"),
            Expanded(
              flex: 2,
              child: DropdownButton(
                value: model.value,
                items: DeviceModel.values
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) => model.value = value!,
                hint: const Text("board"),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text("Communication protocol to use:"),
            Expanded(
              flex: 2,
              child: DropdownButton(
                value: protocol.value,
                items: DeviceProtocol.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (value) => protocol.value = value!,
                hint: const Text("protocol"),
              ),
            ),
          ],
        ),
        // TODO: address cannot be written in TextField.
        //  Create a device research page, with awaitable result
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: "address:port"),
                controller: addressController,
              ),
            ),
            OutlinedButton(
                onPressed: () => getAddress(),
                child: const Text('FIND MY DEVICE'))
          ],
        ),
        Row(
          children: [
            TextButton(onPressed: () => cancel(), child: const Text('CANCEL')),
            ElevatedButton(
                onPressed: () => validate(
                      Device(
                          name: nameController.text,
                          model: model.value,
                          protocol: protocol.value,
                          address: addressController.text),
                    ),
                child: const Text("VALIDATE"))
          ],
        )
      ],
    );
  }
}