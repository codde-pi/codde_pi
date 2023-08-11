import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/theme.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';

class ControllerPropertiesDialog extends StatelessWidget {
  final commandController = TextEditingController();

  ControllerPropertiesDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Controller properties'),
        actions: [
          ElevatedButton(
            child: const Text('SAVE'),
            onPressed: () {
              // FIXME: need devicceId
              /* Navigator.of(context).pop(ControllerProperties(
                  executable: commandController.text)); */
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                Text('For Now, only Socketio protocol is supported')
              ],
            ),
          ),
          const SizedBox(height: widgetGutter),
          Text(
            "Remote command",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Text('Assign remote shell command'),
          TextField(
            decoration: InputDecoration(
                hintText: "command (\$CWD for root project path)",
                border: OutlineInputBorder()),
            controller: commandController,
          )
        ],
      ),
    );
  }
}
