import 'package:codde_pi/app/pages/project/project.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';

import 'community.dart';
import 'devices/devices.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    /* if (!GetIt.I.isRegistered<NavigationBarState>()) {
      GetIt.I.registerSingleton(NavigationBarState());
    } else {
      GetIt.I.get<NavigationBarState>();
    } */
    return DynamicBar(
      pagers: [
        DynamicBarPager.globalProjects,
        DynamicBarPager.community,
        DynamicBarPager.deviceCollection,
        // DynamicBarPager.tools,
      ],
      children: [
        GlobalProjects(),
        Community(),
        Devices(), /* Tools() */
      ],
    );
  }
}
