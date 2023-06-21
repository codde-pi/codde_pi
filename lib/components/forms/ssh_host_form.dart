import 'package:codde_pi/services/db/host.dart';
import 'package:flutter/material.dart';

class SSHHostForm extends StatelessWidget {
  final nameController = TextEditingController();
  final pswdController = TextEditingController();
  final portController = TextEditingController(text: "22");
  final hostController = TextEditingController();

  final Function cancel;
  final Function validate;

  SSHHostForm({super.key, required this.cancel, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          decoration: InputDecoration(hintText: "name"),
          controller: nameController,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                decoration: InputDecoration(hintText: "host"),
                controller: hostController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: "port"),
                controller: portController,
              ),
            ),
          ],
        ),
        TextField(
          decoration: InputDecoration(hintText: "password"),
          controller: pswdController,
        ),
        Row(
          children: [
            TextButton(onPressed: () => cancel(), child: Text('cancel')),
            ElevatedButton(
                onPressed: () => validate(
                      Host(
                        name: nameController.text,
                        ip: hostController.text,
                        pswd: pswdController.text,
                        port: int.parse(portController.text),
                      ),
                    ),
                child: Text("validate"))
          ],
        )
      ],
    );
  }
}
