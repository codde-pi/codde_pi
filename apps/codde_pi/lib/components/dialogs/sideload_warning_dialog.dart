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
                    child: Text(project.remoteDestination ?? '---'))),
          ),
        ],
      )),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('CANCEL')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) =>
                      SideloadProgressDialog(project: project));
            },
            child: const Text('FLASH'))
      ],
    );
  }
}

class SideloadProgressDialog extends StatelessWidget {
  Project project;
  SideloadProgressDialog({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sideload"),
      content: StreamBuilder(
          stream: sideloadProject(context, project: project),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return const Text('Done');
            }
            return LinearProgressIndicator(
                // value: snapshot.data,
                );
          }),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('CANCEL')),
      ],
    );
  }
}
