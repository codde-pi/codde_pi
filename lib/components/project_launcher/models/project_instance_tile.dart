import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';

class ProjectInstanceTile extends StatelessWidget {
  final Project project;
  final Function select;
  ProjectInstanceTile({required this.project, required this.select});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: select(context, project),
      leading: project.controlledDevice != null
          ? Icon(Icons.settings_remote)
          : Icon(Icons.electrical_services_sharp),
      title: Text(project.name),
      subtitle: Text("${project.dateCreated.day}/${project.dateCreated.month}"),
      trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          onPressed: () {/* TODO: expand to card with full informations */}),
    );
  }
}
