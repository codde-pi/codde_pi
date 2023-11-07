import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/components/navigation_bar/navigation_bar.dart';
import 'package:codde_pi/components/navigation_bar/navigation_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    /* if (!GetIt.I.isRegistered<NavigationBarState>()) {
      GetIt.I.registerSingleton(NavigationBarState());
    } else {
      GetIt.I.get<NavigationBarState>();
    } */
    return NavBar();
  }
}
