import 'package:codde_pi/app/pages/project/project.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:flutter/material.dart';

class DynamicBarPager {
  static final globalProjects = DynamicBarDestination(
    widget: GlobalProjects(),
    iconData: Icons.tab,
    index: 0,
  );
  static final dummyDestination = DynamicBarDestination(
      widget: Container(
        color: Colors.red,
      ),
      iconData: Icons.collections,
      index: 1);
}
