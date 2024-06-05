import 'package:flutter/widgets.dart';

class DynamicBarMenuItem {
  final String name;
  final IconData iconData;
  final Widget? widget;
  DynamicBarMenuItem({required this.name, required this.iconData, this.widget});
}
