import 'dart:async';

import 'package:flutter/widgets.dart';

import 'dynamic_bar_destination.dart';

class DynamicBarMenuItem {
  final DynamicBarDestination destination;
  final Widget? widget;
  final FutureOr<bool> Function(BuildContext)? onPressed;
  DynamicBarMenuItem({required this.destination, this.widget, this.onPressed});
}
