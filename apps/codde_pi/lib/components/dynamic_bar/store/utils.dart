import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void setFab({
  required BuildContext context,
  required DynamicFab? fab,
}) {
  final p = Provider.of<DynamicFabNotifier>(context, listen: false);
  p.setFromFab(fab);
}

void disableFab(BuildContext context) {
  final p = Provider.of<DynamicFabNotifier>(context, listen: false);
  p.disableFab();
}

void addStep(BuildContext context, Widget step) {
  final p = Provider.of<DynamicBreadNotifier>(context, listen: false);
  p.addStep(step);
}

void selectStep(BuildContext context, int index,
    [DynamicBarDestination? section]) {
  final p = Provider.of<DynamicBreadNotifier>(context, listen: false);
  p.selectStep(index);

  final pS = Provider.of<DynamicSectionNotifier>(context, listen: false);
  pS.selectSection(pS.currentSection, section);
}

void moveStepForward(BuildContext context, [DynamicBarDestination? section]) {
  final p = Provider.of<DynamicBreadNotifier>(context, listen: false);
  p.moveForward();
  // TODO: duplicate
  final pS = Provider.of<DynamicSectionNotifier>(context, listen: false);
  pS.selectSection(pS.currentSection, section);
}

void selectSection(BuildContext context, int index,
    [DynamicBarDestination? section]) {
  final pS = Provider.of<DynamicSectionNotifier>(context, listen: false);
  pS.selectSection(index, section);
}
