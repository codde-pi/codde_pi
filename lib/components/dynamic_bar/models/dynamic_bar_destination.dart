import 'package:flutter/material.dart';

class DynamicBarDestination {
  Widget Function() widget;
  final int index;
  final IconData iconData;
  final String name;
  Widget? builtWidget;

  DynamicBarDestination._internal(
      {required this.widget,
      required this.index,
      required this.iconData,
      required this.name});

  factory DynamicBarDestination(
      {required Widget Function() widget,
      Widget? builtWidget,
      required int index,
      required IconData iconData,
      required String name}) {
    var destination = DynamicBarDestination._internal(
        widget: widget, index: index, iconData: iconData, name: name);
    destination.widget = () {
      Widget w = widget();
      destination.builtWidget = w;
      return w;
    };
    return destination;
  }
}
