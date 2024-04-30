import 'dart:async';

import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/controller_editor/controller_editor.dart';
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

class CoddeOverview extends DynamicBarWidget {
  late Project coddeProject;
  late final controllerEditor = ControllerEditor(
    path: getControllerName(path: coddeProject.workDir),
  );

  late CodeViewer editor = CodeViewer(
    readOnly: false,
    workDir: coddeProject.workDir,
  );

  late final terminalInstance = CoddeTerminal();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    coddeProject = Provider.of<CoddeState>(context).project;
    if (coddeProject == null) {
      throw RuntimeProjectException();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(coddeProject.name),
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.flash_on,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () =>
                sideloadProjectDialog(context, project: coddeProject),
          ),
          PopupMenuButton<OverviewActions>(
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
          ),
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

  @override
  List<DynamicBarMenuItem> get bottomMenu => [
        DynamicBarMenuItem(
          name: "Overview",
          iconData: Icons.gamepad,
          destination: DynamicBarPager.coddeOverview(instance: this),
        ),
        DynamicBarMenuItem(
          name: "Controller",
          iconData: Icons.gamepad,
          destination:
              DynamicBarPager.controllerEditor(instance: controllerEditor),
        ),
        DynamicBarMenuItem(
          name: "Editor",
          iconData: Icons.code,
          destination: DynamicBarPager.editor(instance: editor),
        ),
        /* if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Dashboard",
              iconData: Icons.dashboard,
              destination: DynamicBarPager.dashboard), */
        if (coddeProject.device.host != null)
          DynamicBarMenuItem(
            name: "Terminal",
            iconData: Icons.terminal,
            destination: DynamicBarPager.terminal(instance: terminalInstance),
          ),
        DynamicBarMenuItem(name: "Exit", iconData: Icons.exit_to_app)
      ];

  void updateMenu(context, int index) {
    if (index == getLastMenuIndex) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      // TODO: duplicated
      bar.selectMenuItem(index);
    }
  }

  @override
  void setFab(BuildContext context) {
    // TODO: implement setFab
  }

  @override
  void setIndexer(BuildContext context) {
    bar.setIndexer((p0) => updateMenu(context, p0));
  }
}
