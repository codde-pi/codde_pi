import 'package:codde_pi/app/pages/codde/cubit/codde_cubit.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Codde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /* BlocProvider(
            create: (_) => DynamicBarCubit(
                pager: [DynamicBarPager.controller, DynamicBarPager.editor]),
          ), */
        BlocProvider(
          create: (_) => CoddeCubit(Get.arguments),
        ),
      ],
      child: DynamicBar(nested: true),
    );
  }
}
