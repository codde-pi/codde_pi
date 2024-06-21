import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/controller_editor/flame/controller_editor_game.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoddeWrapper extends StatefulWidget {
  const CoddeWrapper({super.key});

  @override
  State<CoddeWrapper> createState() {
    return _CoddeWrapperState();
  }
}

class _CoddeWrapperState extends State<CoddeWrapper> {
  late final coddeProject = Provider.of<CoddeState>(context).project;
  late final provider = Provider.of<DynamicMenuNotifier>(context);

  @override
  Widget build(BuildContext context) {
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
      section: DynamicBarPager.coddeWorkspace,
      pages: [
        DynamicBarMenuItem(
          destination: DynamicBarPager.coddeOverview,
          widget: CoddeOverview(),
        ),
        DynamicBarMenuItem(
          destination: DynamicBarPager.controllerEditor,
          widget: ControllerEditorGame(
                  getControllerName(path: coddeProject.workDir))
              .overlayBuilder(context),
        ),
        DynamicBarMenuItem(
          destination: DynamicBarPager.codeEditor,
          widget: CodeViewer(readOnly: false, workDir: coddeProject.workDir),
        ),
        /* if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Dashboard",
              iconData: Icons.dashboard,
              destination: DynamicBarPager.dashboard), */
        if (coddeProject.device.host != null)
          DynamicBarMenuItem(
              destination: DynamicBarPager.terminal, widget: CoddeTerminal()),
        DynamicBarMenuItem(destination: DynamicBarPager.exit, onPressed: exit),
      ],
    );
  }

  bool exit(BuildContext context) {
    // TODO: improve
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/');
    return true;
  }
}
