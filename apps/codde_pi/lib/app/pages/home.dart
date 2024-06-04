import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';

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
      children: [
        DynamicBarPager.globalProjects,
        DynamicBarPager.community,
        DynamicBarPager.devices
      ],
    );
  }
}
