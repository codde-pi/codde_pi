import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
import 'package:codde_pi/components/code_viewer/code_viewer.dart';
import 'package:codde_pi/components/controller_editor/controller_editor.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:flutter/material.dart';

class DynamicBarPager {
  /* static final dummyDestination = DynamicBarDestination(
      name: "dummy",
      widget: Container(
        color: Colors.red,
      ),
      iconData: Icons.collections,
      index: 1); */
  // Codde menu
  static DynamicBarDestination coddeOverview = DynamicBarDestination(
      name: "WORKSPACE - EDIT MODE", index: 0, iconData: Icons.tab);
  static DynamicBarDestination editor({required CodeViewer instance}) =>
      DynamicBarDestination(
          name: "code editor", index: 1, iconData: Icons.code);
  /* static final device = DynamicBarDestination(
      name: "device",
      widget: CoddeDeviceDetails(),
      index: 2,
      iconData: Icons.toys); */
  static final dashboard =
      DynamicBarDestination(name: "dashboard", index: 2, iconData: Icons.dns);
  static DynamicBarDestination terminal({required CoddeTerminal instance}) =>
      DynamicBarDestination(
          name: "terminal", index: 3, iconData: Icons.terminal);
  static final diagram =
      DynamicBarDestination(name: "diagram", index: 4, iconData: Icons.cable);
  // Main menu
  static final globalProjects = DynamicBarDestination(
    name: "projects",
    iconData: Icons.tab,
    index: 0,
  );
  static final community = DynamicBarDestination(
      name: "community", index: 1, iconData: Icons.language);
  static final devices =
      DynamicBarDestination(name: "devices", index: 2, iconData: Icons.toys);
  static final deviceCollection =
      DynamicBarDestination(name: "COLLECTION", index: 2, iconData: Icons.toys);
  static final deviceGarage =
      DynamicBarDestination(name: "GARAGE", index: 2, iconData: Icons.toys);
  static final devicePlayground =
      DynamicBarDestination(name: "PLAYGROUND", index: 2, iconData: Icons.toys);

  /* static final boards = DynamicBarDestination(
      name: "boards", widget: () => const Boards(), index: 2, iconData: Icons.cable); */
  static final settings = DynamicBarDestination(
      name: "settings", index: 2, iconData: Icons.settings);
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
      index: 1,
      iconData: Icons.devices,
    );
  }

  static DynamicBarDestination controllerEditor(
          {required ControllerEditor instance}) =>
      DynamicBarDestination(
        name: "controller editor",
        index: 2,
        iconData: Icons.roller_shades,
      );
  static DynamicBarDestination controllerPlayer({required String workdir}) =>
      DynamicBarDestination(
        name: "controller",
        index: 2,
        iconData: Icons.roller_shades,
      );
}
