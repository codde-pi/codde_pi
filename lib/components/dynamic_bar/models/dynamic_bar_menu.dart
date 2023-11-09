import 'package:flutter/widgets.dart';

import 'dynamic_bar_destination.dart';

class DynamicBarMenuItem {
  final String name;
  final IconData iconData;
  final DynamicBarDestination? destination;
  DynamicBarMenuItem(
      {required this.name, required this.iconData, this.destination});
}
