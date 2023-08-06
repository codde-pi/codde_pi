import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final List<DynamicBarDestination> destinations = [
    DynamicBarPager.globalProjects,
    DynamicBarPager.community,
    // DynamicBarPager.boards,
    // DynamicBarPager.tools,
    DynamicBarPager.settings,
  ];

  @override
  Widget build(BuildContext context) {
    if (!GetIt.I.isRegistered<DynamicBarState>()) {
      GetIt.I.registerSingleton(DynamicBarState(destinations: destinations));
    } else {
      GetIt.I.get<DynamicBarState>().defineDestinations(context, destinations);
    }
    return DynamicBar();
  }
}
