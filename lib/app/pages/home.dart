import 'package:codde_pi/components/dynamic_bar/cubit/dynamic_bar_cubit.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DynamicBarCubit(pager: [
        DynamicBarPager.globalProjects,
        DynamicBarPager.dummyDestination
      ]),
      child: const DynamicBar(),
    );
  }
}
