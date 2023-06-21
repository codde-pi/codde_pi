import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/core/codde_controller/store/codde_controller_store.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Codde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DynamicBarState>(
          create: (_) => DynamicBarState(destinations: [
            DynamicBarPager.controller,
            DynamicBarPager.editor
            // TODO: diagram, device
          ]),
        ),
        Provider<CoddeControllerStore>(
          create: (_) => CoddeControllerStore(),
        ),
        Provider<CoddeState>(
            create: (_) => CoddeState(
                ModalRoute.of(context)!.settings.arguments as Project)),
      ],
      child: DynamicBar(nested: true),
    );
  }
}
