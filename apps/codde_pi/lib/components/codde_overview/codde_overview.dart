import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/views/device_details.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/project_details.dart';

enum OverviewActions { downloadProject }

class CoddeOverview extends StatelessWidget {
  late Project coddeProject;

  @override
  Widget build(BuildContext context) {
    coddeProject = Provider.of<CoddeState>(context).project;
    if (coddeProject == null) {
      throw RuntimeProjectException();
    }
    final backend = getLocalBackend();
    setFab(context: context, fab: null);

    return Scaffold(
      appBar: AppBar(
        title: Text(coddeProject.name),
        leading: Container(),
        // TODO: clean download code process
        actions: [
          IconButton(
            icon: Icon(
              Icons.flash_on,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () =>
                sideloadProjectDialog(context, project: coddeProject),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              backend.isOpen ? Icons.link : Icons.link_off,
              color: backend.isOpen
                  ? Colors.green
                  : Theme.of(context).disabledColor,
            ),
          )
          /*PopupMenuButton<OverviewActions>(
            initialValue: null,
            onSelected: (OverviewActions? item) {
              switch (item) {
                case OverviewActions.downloadProject:
                  Navigator.of(context).pop();
                  downloadProjectDialog(context, project: coddeProject);
                  break;
                default:
                  null;
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<OverviewActions>>[
              const PopupMenuItem<OverviewActions>(
                value: OverviewActions.downloadProject,
                child: Text('Download embedded code'),
              ),
            ],
          ),*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(widgetGutter) / 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectDetails(project: coddeProject),
              const SizedBox(height: widgetSpace),
              /* Text(
                "Device",
                style: Theme.of(context).textTheme.headlineSmall,
              ), */
              DeviceDetails(device: coddeProject.device),
              const SizedBox(height: widgetSpace),
              // TODO: metadata (README, LICENSE, pyproject.toml, CHANGELOG?)
            ],
          ),
        ),
      ),
    );
  }
}
