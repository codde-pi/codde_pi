import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/database.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class SideloadWarningDialog extends StatelessWidget {
  Project project;
  String? destinationPath;
  SideloadWarningDialog(
      {super.key, required this.project, this.destinationPath});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Warning"),
      content: Text.rich(TextSpan(
        children: <InlineSpan>[
          const TextSpan(
              text:
                  "Session need to be reload in order to run the current project in your host.\nFiles and history should be sideloaded automatically.\nYou will still find a backup of this project in the app cache: "),
          WidgetSpan(
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(widgetGutter),
                    child: Text(project.path))),
          ),
        ],
      )),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('CANCEL')),
        ElevatedButton(
            onPressed: () async => sideloadProject(context,
                    project: project, destinationPath: destinationPath)
                .then((_) =>
                    Navigator.of(context).pushReplacementNamed('/codde')),
            child: const Text('RELOAD'))
      ],
    );
  }
}
