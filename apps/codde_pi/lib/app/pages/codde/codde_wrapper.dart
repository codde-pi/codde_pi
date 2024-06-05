import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/controller_editor/flame/controller_editor_game.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoddeWrapper extends StatelessWidget {
  const CoddeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final coddeProject = Provider.of<CoddeState>(context).project;
    final provider = Provider.of<DynamicMenuNotifier>(context);
    if (coddeProject == null) {
      throw RuntimeProjectException();
    }
    return DynamicBarScaffold(
      indexer: (context, index) {
        if (index == provider.getLastMenuIndex) {
          // TODO: improve
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/');
          return true;
        }
        return false;
      },
      section: DynamicBarPager.coddeOverview,
      pages: [
        DynamicBarMenuItem(
          name: "Overview",
          iconData: Icons.gamepad,
          widget: CoddeOverview(),
        ),
        DynamicBarMenuItem(
          name: "Controller",
          iconData: Icons.gamepad,
          widget: ControllerEditorGame(
                  getControllerName(path: coddeProject.workDir))
              .overlayBuilder(context),
        ),
        DynamicBarMenuItem(
          name: "Editor",
          iconData: Icons.code,
          widget: CodeViewer(readOnly: false, workDir: coddeProject.workDir),
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
              widget: CoddeTerminal()),
        DynamicBarMenuItem(name: "Exit", iconData: Icons.exit_to_app)
      ],
    );
  }
}
