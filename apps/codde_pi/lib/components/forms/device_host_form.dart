import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/dialogs/file_picker_dialog.dart';
import 'package:codde_pi/components/file_picker/file_picker.dart';
import 'package:codde_pi/components/utils/ip_device_finder.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceHostForm extends StatelessWidget {
  final pathController = TextEditingController();
  final userController = TextEditingController();
  final pswdController = TextEditingController();
  final portController = TextEditingController(text: "22");
  late final hostController =
      TextEditingController(text: getHostAddrFromDeviceAddr(device.addr));

  final Function? cancel;
  final Function? validate;
  final Device device;

  DeviceHostForm(
      {super.key,
      required this.device,
      required this.cancel,
      required this.validate});
  void getAddress(BuildContext context) async {
    var value = await showGeneralDialog<String?>(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IpDeviceFinder()) ??
        '';
    if (value != null) {
      hostController.value = TextEditingValue(
          text: value,
          selection: TextSelection(
              baseOffset: value.length, extentOffset: value.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "username"),
          controller: userController,
          onFieldSubmitted: (value) => pathController.text = "/home/$value",
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
              ),
            ),
            const SizedBox(width: widgetGutter / 2),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "port"),
                controller: portController,
              ),
            ),
          ],
        ),
        const SizedBox(height: widgetGutter / 2),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () => getAddress(context),
            child: const Text('FIND MY HOST'),
          ),
        ),
        const SizedBox(height: widgetGutter),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "password"),
          controller: pswdController,
        ),
        const SizedBox(height: widgetGutter),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "working directory"),
                controller: pathController,
              ),
            ),
            const SizedBox(width: widgetGutter / 2),
            OutlinedButton(
                onPressed: () async {
                  if (hostController.text.isEmpty ||
                      userController.text.isEmpty ||
                      pswdController.text.isEmpty ||
                      portController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all fields"),
                    ));
                    return;
                  }
                  final backend = CoddeBackend(BackendLocation.server,
                      credentials: SFTPCredentials(
                          host: hostController.text,
                          pswd: pswdController.text,
                          user: userController.text,
                          port: int.parse(portController.text)));
                  await backend.open();
                  final res = await showDialog(
                      context: context,
                      builder: (context) => FilePickerDialog(
                          backend: backend,
                          pickMode: PickMode.folder,
                          workDir: "/home/$userController.text"));
                  backend.close();
                  if (res != null) pathController.text = res;
                },
                child: const Text(
                  'FIND WORKING DIR',
                )),
          ],
        ),
        const SizedBox(height: widgetGutter),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (cancel != null)
              TextButton(
                  onPressed: () => cancel!(), child: const Text('cancel')),
            if (validate != null)
              ElevatedButton(
                  onPressed: () => validate!(
                        Host(
                          pushDir: pathController.text,
                          user: userController.text,
                          addr: hostController.text,
                          pswd: pswdController.text,
                          port: int.parse(portController.text),
                        ),
                      ),
                  child: const Text("validate"))
          ],
        )
      ],
    );
  }
}
