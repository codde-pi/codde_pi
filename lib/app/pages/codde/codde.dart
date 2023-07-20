import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/core/codde_controller/store/codde_controller_store.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Codde extends StatelessWidget {
  const Codde({super.key});

  void registerBackend(project) {
    final backend = CoddeBackend(
        project.host == null ? BackendLocation.local : BackendLocation.server);
    GetIt.I.registerLazySingleton<CoddeBackend>(() => backend);
  }

  void registerHost(project) async {
    if (project.host != null) {
      if (!GetIt.I.isRegistered<SSHClient>()) {
        final sshClient = SSHClient(
            await SSHSocket.connect(project.host!.ip, project.host!.port!),
            username: project.host!.user,
            onPasswordRequest: () => project.host!.pswd);
        GetIt.I.registerSingleton(sshClient);
        GetIt.I
            .registerLazySingleton(() => CoddeBackend.fromInstance(sshClient));
      }

      registerBackend(project);
    } else {
      if (!GetIt.I.isRegistered<CoddeBackend>()) {
        registerBackend(project);
      }
    }
  }

  void unregisterBackend() {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>();
    }
    if (GetIt.I.isRegistered<SSHClient>()) GetIt.I.unregister<SSHClient>();
  }

  @override
  Widget build(BuildContext context) {
    final bar = GetIt.I.get<DynamicBarState>();
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    registerHost(project);
    bar.defineDestinations([
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
