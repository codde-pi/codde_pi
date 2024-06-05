import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_controller/flame/overview_controller_flame.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/play_controller/play_controller.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DevicePlayground extends StatefulWidget {
  DevicePlayground({Key? key, required this.project}) : super(key: key);
  final Project project;
  final backend = CoddeBackend(BackendLocation.local);

  @override
  State<StatefulWidget> createState() {
    return _DevicePlayground();
  }
}

class _DevicePlayground extends State<DevicePlayground> {
  @override
  Widget build(BuildContext context) {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>();
    }
    GetIt.I.registerSingleton(widget.backend);

    return DynamicBarScaffold(
      fab: DynamicFab(
          iconData: Icons.play_arrow,
          action: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayController(
                  path: getControllerName(path: widget.project.workDir))))),
      pages: [
        DynamicBarMenuItem(
          name: "Controller",
          iconData: Icons.gamepad,
          widget: GameWidget(
            game: OverviewControllerFlame(
                path: getControllerName(path: widget.project.workDir),
                backend: widget.backend),
          ),
        ),
        DynamicBarMenuItem(
          name: "Code",
          iconData: Icons.code,
          widget: CodeViewer(
            workDir: widget.project.workDir,
            readOnly: true,
          ),
        ),
        // TODO: informations (pyproject.toml)
      ],
      section: DynamicBarPager.devicePlayground,
      // appBar: AppBar(title: Text(project.name)),
    );
  }
}
