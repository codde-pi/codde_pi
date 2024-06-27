// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/codde_wrapper.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Codde extends StatefulWidget {
  const Codde({super.key});

  @override
  State<StatefulWidget> createState() => _Codde();
}

class _Codde extends State<Codde> {
  Project? project;
  bool connectionInfoShown = false;
  late final loadBackend =
      registerBackend(project: project).timeout(const Duration(seconds: 10));

  Future<void> registerBackend({required Project? project}) async {
    if (project == null)
      throw RuntimeProjectException('Project should not be null');
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      final backend = CoddeBackend(BackendLocation.server,
          credentials: project.device.host?.toCredentials());
      await backend.open().then(
          (_) => GetIt.I.registerLazySingleton<CoddeBackend>(() => backend));
    } else {
      final backend = GetIt.I.get<CoddeBackend>();
      if (!backend.isRunning) await backend.open();
    }
  }

  void unregisterBackend() {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>(
          disposingFunction: (value) => value.close());
    }
  }

  /* @override
  void deactivate() {
    unregisterBackend();
    super.deactivate();
  } */

  @override
  void initState() {
    logger.d('Codde initState');
    super.initState();
  }

  @override
  void dispose() {
    unregisterBackend();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    project = ModalRoute.of(context)!.settings.arguments as Project;
    assert(project != null, 'Project should not be null');
    return FutureBuilder(
      future: loadBackend,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            (!GetIt.I
                .isRegistered<CoddeBackend>() /* || backend.isNotOpen */)) {
          return Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Establishing connection with Host',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: widgetGutter),
              const Padding(
                padding:
                    EdgeInsets.only(left: widgetGutter, right: widgetGutter),
                child: LinearProgressIndicator(),
              )
            ],
          ));
        }
        if (snapshot.hasError) {
          if (!connectionInfoShown)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Host connection failed. \n${snapshot.error}",
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                      const SizedBox(height: widgetGutter / 2),
                      TextButton(
                          onPressed: () {
                            unregisterBackend();
                            setState(() {});
                          },
                          child: const Text('RETRY'))
                    ],
                  ),
                ),
              );
              connectionInfoShown = true;
            });
        }
        return MultiProvider(
          providers: [
            Provider<CoddeState>(
              create: (_) => CoddeState(project!),
            ),
          ],
          builder: (context, widget) {
            return DynamicBar(
              nested: true,
              pagers: [
                DynamicBarPager.coddeWorkspace,
              ],
              child: const CoddeWrapper(),
            );
          },
        );
      },
    );
  }
}
