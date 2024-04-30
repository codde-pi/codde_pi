import 'package:codde_pi/app/pages/boards.dart';
import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/app/pages/codde/dashboard/dashboard.dart';
import 'package:codde_pi/app/pages/codde/editor/codde_editor.dart';
import 'package:codde_pi/app/pages/community.dart';
import 'package:codde_pi/app/pages/devices/devices.dart';
import 'package:codde_pi/app/pages/project/project.dart';
import 'package:codde_pi/app/pages/settings/settings.dart';
import 'package:codde_pi/app/pages/tools.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/controller_editor/controller_editor.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/play_controller/play_controller.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class DynamicBarPager {
  /* static final dummyDestination = DynamicBarDestination(
      name: "dummy",
      widget: Container(
        color: Colors.red,
      ),
      iconData: Icons.collections,
      index: 1); */
  // Codde menu
  static DynamicBarDestination coddeOverview(
          {required CoddeOverview instance}) =>
      DynamicBarDestination(
          name: "WORKSPACE",
          widget: () => CoddeOverview(),
          index: 0,
          iconData: Icons.tab);
  static DynamicBarDestination editor({required CodeViewer instance}) =>
      DynamicBarDestination(
          name: "code editor",
          widget: () => instance,
          index: 1,
          iconData: Icons.code);
  /* static final device = DynamicBarDestination(
      name: "device",
      widget: CoddeDeviceDetails(),
      index: 2,
      iconData: Icons.toys); */
  static final dashboard = DynamicBarDestination(
      name: "dashboard",
      widget: () => Dashboard(),
      index: 2,
      iconData: Icons.dns);
  static DynamicBarDestination terminal({required CoddeTerminal instance}) =>
      DynamicBarDestination(
          name: "terminal",
          widget: () => CoddeTerminal(),
          index: 3,
          iconData: Icons.terminal);
  static final diagram = DynamicBarDestination(
      name: "diagram",
      widget: () => CoddeDiagram(),
      index: 4,
      iconData: Icons.cable);
  // Main menu
  static final globalProjects = DynamicBarDestination(
    name: "projects",
    widget: () => GlobalProjects(),
    iconData: Icons.tab,
    index: 0,
  );
  static final community = DynamicBarDestination(
      name: "community",
      widget: () => Community(),
      index: 1,
      iconData: Icons.language);
  static final devices = DynamicBarDestination(
      name: "devices",
      widget: () => Devices(),
      index: 2,
      iconData: Icons.devices);

  /* static final boards = DynamicBarDestination(
      name: "boards", widget: () => const Boards(), index: 2, iconData: Icons.cable); */
  static final settings = DynamicBarDestination(
      name: "settings",
      widget: () => Settings(),
      index: 2,
      iconData: Icons.settings);
  /* static final tools = DynamicBarDestination(
      name: "tools", widget: () => const Tools(), index: 3, iconData: Icons.pan_tool); */
  /* static DynamicBarDestination deviceProjects({required Device device}) =>
      DynamicBarDestination(
        name: "device projects",
        widget: () => DeviceGarage(device: device),
        index: 0,
        iconData: Icons.devices,
      ); */
  static DynamicBarDestination deviceDiagramEditor(
      {required CoddeDiagram instance}) {
    print('diagram destination');
    return DynamicBarDestination(
      name: "device diagram editor",
      widget: () {
        print('diagram call');
        return instance;
      },
      index: 1,
      iconData: Icons.devices,
    );
  }

  static DynamicBarDestination controllerEditor(
          {required ControllerEditor instance}) =>
      DynamicBarDestination(
        name: "controller editor",
        widget: () => instance,
        index: 2,
        iconData: Icons.roller_shades,
      );
  static DynamicBarDestination controllerPlayer({required String workdir}) =>
      DynamicBarDestination(
        name: "controller",
        widget: () => PlayController(path: getControllerName(path: workdir)),
        index: 2,
        iconData: Icons.roller_shades,
      );
}
