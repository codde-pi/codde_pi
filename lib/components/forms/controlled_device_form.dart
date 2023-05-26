import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:flutter/material.dart';

class ControlledDeviceForm extends StatelessWidget {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final protocol = ValueNotifier(DeviceProtocol.socketio);
  final model = ValueNotifier(DeviceModel.sbc);

  final Function cancel;
  final Function validate;

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
                items: DeviceModel.values
                    .map((e) => DropdownMenuItem(child: Text(e.name)))
                    .toList(),
                onChanged: (value) => model.value = value,
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
                items: DeviceProtocol.values
                    .map((e) => DropdownMenuItem(child: Text(e.name)))
                    .toList(),
                onChanged: (value) => model.value = value,
                hint: const Text("protocol"),
              ),
            ),
          ],
        ),
        // TODO: address cannot be written in TextField.
        //  Create a device research page, with awaitable result
        TextField(
          decoration: InputDecoration(hintText: "address"),
          controller: addressController,
        ),
        Row(
          children: [
            TextButton(onPressed: () => cancel(), child: Text('cancel')),
            ElevatedButton(
                onPressed: () => validate(
                      Device(
                          name: nameController.text,
                          model: model.value,
                          protocol: protocol.value,
                          address: addressController.text),
                    ),
                child: Text("validate"))
          ],
        )
      ],
    );
  }
}
