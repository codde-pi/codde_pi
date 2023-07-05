import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/core/codde_controller/store/codde_controller_store.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Codde extends StatelessWidget {
  const Codde({super.key});

  @override
  Widget build(BuildContext context) {
    final bar = GetIt.I.get<DynamicBarState>();
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    final backend = CoddeBackend(
        project.host == null ? BackendLocation.local : BackendLocation.server);
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.registerLazySingleton<CoddeBackend>(() => backend);
    }
    bar.defineDestinations([
      DynamicBarPager.controller,
      DynamicBarPager.editor
      // TODO: diagram, device
    ]);
    return MultiProvider(
      providers: [
        Provider<CoddeControllerStore>(
          create: (_) => CoddeControllerStore(),
        ),
        Provider<CoddeState>(
          create: (_) => CoddeState(project),
        ),
      ],
      child: const DynamicBar(nested: true),
    );
  }
}
