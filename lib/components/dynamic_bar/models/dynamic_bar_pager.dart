import 'package:codde_pi/app/pages/boards.dart';
import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/app/pages/codde/codde_editor.dart';
import 'package:codde_pi/app/pages/codde/dashboard/dashboard.dart';
import 'package:codde_pi/app/pages/community.dart';
import 'package:codde_pi/app/pages/project/project.dart';
import 'package:codde_pi/app/pages/settings/settings.dart';
import 'package:codde_pi/app/pages/tools.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal.dart';
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
  static final controller = DynamicBarDestination(
      name: "controller",
      widget: () => CoddeController(),
      index: 0,
      iconData: Icons.gamepad);
  static final editor = DynamicBarDestination(
      name: "editor",
      widget: () => CoddeEditor(),
      index: 1,
      iconData: Icons.code);
  /* static final device = DynamicBarDestination(
      name: "device",
      widget: CoddeDeviceDetails(),
      index: 2,
      iconData: Icons.toys); */
  static final dashboard = DynamicBarDestination(
      name: "dashboard",
      widget: () => CoddeHost(),
      index: 2,
      iconData: Icons.dns);
  static final terminal = DynamicBarDestination(
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
  /* static final boards = DynamicBarDestination(
      name: "boards", widget: () => const Boards(), index: 2, iconData: Icons.cable); */
  static final settings = DynamicBarDestination(
      name: "settings",
      widget: () => Settings(),
      index: 2,
      iconData: Icons.settings);
  /* static final tools = DynamicBarDestination(
      name: "tools", widget: () => const Tools(), index: 3, iconData: Icons.pan_tool); */
}
