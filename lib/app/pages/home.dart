import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetIt.I.registerLazySingleton(() => DynamicBarState(destinations: [
          DynamicBarPager.globalProjects,
          DynamicBarPager.dummyDestination
        ]));
    return const DynamicBar();
  }
}
