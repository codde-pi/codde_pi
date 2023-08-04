import 'package:codde_pi/components/utils/ip_device_finder.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class SSHHostForm extends StatelessWidget {
  final nameController = TextEditingController();
  final userController = TextEditingController();
  final pswdController = TextEditingController();
  final portController = TextEditingController(text: "22");
  final hostController = TextEditingController();

  final Function cancel;
  final Function validate;

  SSHHostForm({super.key, required this.cancel, required this.validate});
  void getAddress(BuildContext context) async {
    var value = await showGeneralDialog<String?>(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IpDeviceFinder()) ??
        '';
    if (value != null)
      hostController.value = TextEditingValue(
          text: value,
          selection: TextSelection(
              baseOffset: value.length, extentOffset: value.length));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Name"),
          controller: nameController,
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
        OutlinedButton(
          onPressed: () => getAddress(context),
          child: const Text('FIND MY HOST'),
        ),
        const SizedBox(height: widgetGutter),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "password"),
          controller: pswdController,
        ),
        const SizedBox(height: widgetGutter),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () => cancel(), child: const Text('cancel')),
            ElevatedButton(
                onPressed: () => validate(
                      Host(
                        name: nameController.text,
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
