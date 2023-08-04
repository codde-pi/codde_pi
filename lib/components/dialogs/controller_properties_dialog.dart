import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class ControllerPropertiesDialog extends StatelessWidget {
  final commandController = TextEditingController();

  ControllerPropertiesDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Controller properties'),
      content: Column(
        children: [
          // TODO: Add Codde Protocol (dropdown button)
          Text(
            "Communication protocol",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: widgetGutter),
          const Card(
            child: Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: widgetGutter),
                Text('For Now, only Socketio protocol is available')
              ],
            ),
          ),
          const SizedBox(height: widgetGutter),
          Text(
            "Remote command",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Text('Assign remote command to run'),
          TextField(
            controller: commandController,
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('SAVE'),
          onPressed: () {
            Navigator.of(context).pop(commandController.text);
          },
        ),
      ],
    );
  }
}
