import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_controller/flame/overview_controller_flame.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/play_controller/play_controller.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DevicePlayground extends DynamicBarWidget {
  DevicePlayground({Key? key, required this.project}) : super(key: key);
  final Project project;
  final backend = CoddeBackend(BackendLocation.local);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>();
    }
    GetIt.I.registerSingleton(backend);

    return Scaffold(
      // appBar: AppBar(title: Text(project.name)),
      body: GameWidget(
        game: OverviewControllerFlame(
            path: getControllerName(path: project.workDir), backend: backend),
      ),
    );
  }

  @override
  List<DynamicBarMenuItem>? get bottomMenu => [
        DynamicBarMenuItem(
            name: "Controller",
            iconData: Icons.gamepad,
            destination: DynamicBarDestination(
                widget: () => this,
                index: 0,
                iconData: Icons.gamepad,
                name: "controller")),
        DynamicBarMenuItem(
            name: "Code",
            iconData: Icons.code,
            destination: DynamicBarDestination(
                name: "code",
                index: 1,
                widget: () => CodeViewer(
                      workDir: project.workDir,
                      readOnly: true,
                    ),
                iconData: Icons.code))
        // TODO: informations (pyproject.toml)
      ];

  @override
  void setFab(BuildContext context) {
    bar.setFab(
        iconData: Icons.play_arrow,
        action: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayController(
                path: getControllerName(path: project.workDir)))));
  }

  void updateMenu(context, int index) {}

  @override
  void setIndexer(BuildContext context) {
    // bar.setIndexer((p0) => updateMenu(context, p0));
  }
}
