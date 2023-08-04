import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Codde extends StatelessWidget {
  const Codde({super.key});

  void registerBackend(project) {
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      final backend = CoddeBackend(
          project.host == null ? BackendLocation.local : BackendLocation.server,
          credentials: project.host?.project.host.toCredentials());
      GetIt.I.registerLazySingleton<CoddeBackend>(() => backend);
    }
  }

  void unregisterBackend() {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bar = GetIt.I.get<DynamicBarState>();
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    registerBackend(project);
    bar.defineDestinations(context, [
      DynamicBarPager.controller,
      DynamicBarPager.editor,
      DynamicBarPager.device,
      DynamicBarPager.terminal,
      DynamicBarPager.diagram,
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
      child: DynamicBar(
        nested: true,
      ),
    );
  }
}
