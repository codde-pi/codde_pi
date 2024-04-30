import 'package:codde_pi/components/utils/ip_device_finder.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'store/controlled_device_form_store.dart';

class ControlledDeviceForm extends StatefulWidget {
  final Function cancel;
  final Function validate;
  final Device? existingDevice;
  final bool requireHost;

  ControlledDeviceForm(
      {super.key,
      required this.cancel,
      required this.validate,
      required this.requireHost,
      this.existingDevice});

  @override
  State<StatefulWidget> createState() => _ControlledDeviceForm();
}

class _ControlledDeviceForm extends State<ControlledDeviceForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  // host
  final userController = TextEditingController();
  final pswdController = TextEditingController();
  final portController = TextEditingController(text: "22");
  final hostController = TextEditingController();
  // store
  final ControlledDeviceFormStore store = ControlledDeviceFormStore();

  void getAddress(BuildContext context) async {
    addressController.text = await showGeneralDialog<String>(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IpDeviceFinder()) ??
        '';
  }

  bool get validHost =>
      userController.text.isNotEmpty &&
      pswdController.text.isNotEmpty &&
      portController.text.isNotEmpty;

  void obscurePswd() {
    store.toggleObscurePswd();
  }

  @override
  void initState() {
    if (widget.existingDevice != null) {
      nameController.text = widget.existingDevice!.name;
      addressController.text = widget.existingDevice!.addr ?? '';
      store.setModel(widget.existingDevice!.model);
      store.setProtocol(widget.existingDevice!.protocol);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Padding(
        padding: EdgeInsets.all(widgetGutter / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "name"),
              controller: nameController,
            ),
            Row(
              children: [
                const Text("Choose your board:"),
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    alignment: Alignment.centerRight,
                    value: store.modelController,
                    items: DeviceModel.values
                        .map((e) => DropdownMenuItem(
                              child: Text(e.name),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) => store.modelController = value!,
                    hint: const Text("board"),
                  ),
                ),
              ],
            ),
            // TODO: create TAB to select com protocol.
            //  Fields (address e.g.) may vary according to com protocol
            Row(
              children: [
                const Text("Communication protocol to use:"),
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    alignment: Alignment.centerRight,
                    value: store.protocolController,
                    items: Protocol.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (value) => store.protocolController = value!,
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
                    decoration: const InputDecoration(
                        hintText: "address:port", border: OutlineInputBorder()),
                    controller: addressController,
                    onSubmitted: (value) =>
                        hostController.text = value.split(":").first,
                  ),
                ),
                OutlinedButton(
                    onPressed: () => getAddress(context),
                    child: const Text('FIND MY DEVICE'))
              ],
            ),
            if (store.modelController == DeviceModel.sbc) ...[
              const SizedBox(height: widgetGutter),
              Text(
                "SFTP Hosting",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: widgetGutter),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "username"),
                controller: userController,
              ),
              const SizedBox(height: widgetGutter),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "host"),
                      controller: hostController,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: widgetGutter / 2),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "SFTP port"),
                      controller: portController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: widgetGutter / 2),
              OutlinedButton(
                onPressed: () => getAddress(context),
                child: const Text('FIND MY HOST'),
              ),
              const SizedBox(height: widgetGutter),
              Row(
                children: [
                  Expanded(
                    // flex: 6,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "password"),
                      controller: pswdController,
                      obscureText: store.pswdObscured,
                    ),
                  ),
                  const SizedBox(width: widgetGutter / 2),
                  IconButton(
                      onPressed: () => obscurePswd(),
                      icon: store.pswdObscured
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                ],
              ),
              const SizedBox(height: widgetGutter),
              if (store.hostRequiredError)
                Text(
                  'Host fields are required in this context',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => widget.cancel(),
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () {
                      if (widget.requireHost && !validHost) {
                        store.raiseHostRequiredError();
                      }
                      widget.validate(
                        validHost
                            ? Device.andHost(
                                name: nameController.text.trim(),
                                model: store.modelController,
                                protocol: store.protocolController,
                                addr: addressController.text.trim(),
                                user: userController.text.trim(),
                                port: int.parse(portController.text),
                                pswd: pswdController.text.trim(),
                              )
                            : Device(
                                name: nameController.text.trim(),
                                model: store.modelController,
                                protocol: store.protocolController,
                                addr: addressController.text.trim(),
                              ),
                      );
                    },
                    child: const Text("VALIDATE"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
