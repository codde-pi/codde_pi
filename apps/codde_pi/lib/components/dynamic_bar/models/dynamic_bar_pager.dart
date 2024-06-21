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
  static DynamicBarDestination coddeWorkspace = const DynamicBarDestination(
      name: "WORKSPACE - EDIT MODE", iconData: Icons.tab);
  static DynamicBarDestination coddeOverview =
      const DynamicBarDestination(name: "Overview", iconData: Icons.tab);
  static DynamicBarDestination codeEditor =
      const DynamicBarDestination(name: "Code", iconData: Icons.code);
  static DynamicBarDestination exit =
      const DynamicBarDestination(name: "Exit", iconData: Icons.exit_to_app);
  /* static final device = DynamicBarDestination(
      name: "device",
      widget: CoddeDeviceDetails(),
      
      iconData: Icons.toys); */
  static const dashboard =
      DynamicBarDestination(name: "dashboard", iconData: Icons.dns);
  static DynamicBarDestination terminal =
      const DynamicBarDestination(name: "Terminal", iconData: Icons.terminal);
  static const diagram =
      DynamicBarDestination(name: "Diagram", iconData: Icons.cable);
  // Main menu
  static const globalProjects = DynamicBarDestination(
    name: "projects",
    iconData: Icons.tab,
  );
  static const community =
      DynamicBarDestination(name: "community", iconData: Icons.language);
  static const devices =
      DynamicBarDestination(name: "devices", iconData: Icons.toys);
  static const deviceCollection =
      DynamicBarDestination(name: "COLLECTION", iconData: Icons.toys);
  static const deviceGarage =
      DynamicBarDestination(name: "GARAGE", iconData: Icons.toys);
  static const devicePlayground =
      DynamicBarDestination(name: "PLAYGROUND", iconData: Icons.toys);

  /* static final boards = DynamicBarDestination(
      name: "boards", widget: () => const Boards(),  iconData: Icons.cable); */
  static const settings =
      DynamicBarDestination(name: "settings", iconData: Icons.settings);
  /* static final tools = DynamicBarDestination(
      name: "tools", widget: () => const Tools(),  iconData: Icons.pan_tool); */
  static DynamicBarDestination deviceDiagramEditor =
      const DynamicBarDestination(
    name: "device diagram editor",
    iconData: Icons.devices,
  );

  static DynamicBarDestination controllerEditor = const DynamicBarDestination(
    name: "Controller",
    iconData: Icons.roller_shades,
  );
  static DynamicBarDestination controllerPlayer = const DynamicBarDestination(
    name: "Controller",
    iconData: Icons.gamepad,
  );
  static DynamicBarDestination personalDevices =
      const DynamicBarDestination(name: "Personal", iconData: Icons.home);
  static DynamicBarDestination brandDevices =
      const DynamicBarDestination(name: "Brands", iconData: Icons.toys);
  static DynamicBarDestination communityDevices =
      const DynamicBarDestination(name: "Community", iconData: Icons.language);
  static DynamicBarDestination projectsList = const DynamicBarDestination(
      name: "Project List", iconData: Icons.gamepad);
  static DynamicBarDestination getNotified = const DynamicBarDestination(
      name: "Get Notified", iconData: Icons.notifications);
  static DynamicBarDestination donation = const DynamicBarDestination(
      name: "Support Development", iconData: Icons.coffee);
}
