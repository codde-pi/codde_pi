import 'package:flutter/material.dart';

class DynamicBarDestination {
  final Widget widget;
  final int index;
  final IconData iconData;
  final String name;

  DynamicBarDestination(
      {required this.widget,
      required this.index,
      required this.iconData,
      required this.name});
}
