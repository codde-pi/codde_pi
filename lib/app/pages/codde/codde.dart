import 'package:codde_backend/codde_backend.dart';
import 'package:codde_editor/codde_editor.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/main.dart';
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
  Future<void> registerBackend({required Project project}) async {
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      final backend = CoddeBackend(
          project.host == null ? BackendLocation.local : BackendLocation.server,
          credentials: project.host?.toCredentials());
      await backend.open().then(
          (_) => GetIt.I.registerLazySingleton<CoddeBackend>(() => backend));
    }
    /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Connected !"),
      // backgroundColor: Theme.of(context).colorScheme.tertiary,
    )); */
  }

  void unregisterBackend() {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.unregister<CoddeBackend>(
          disposingFunction: (value) => value.close());
    }
  }

  @override
  void deactivate() {
    unregisterBackend();
    super.deactivate();
  }

  @override
  void dispose() {
    unregisterBackend();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bar = GetIt.I.get<DynamicBarState>();
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    print(project);
    return FutureBuilder(
      future: registerBackend(project: project),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: widgetGutter, right: widgetGutter),
                  child: Text(
                    "Host connection failed. ${snapshot.error}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: widgetGutter),
                FloatingActionButton.extended(
                    onPressed: () {
                      unregisterBackend();
                      setState(() {});
                    },
                    label: const Text('RETRY'))
              ],
            ),
          );
        }
        print('UI setup OK');
        return MultiProvider(
            providers: [
              Provider<CoddeControllerStore>(
                create: (_) => CoddeControllerStore(),
              ),
              Provider<CoddeState>(
                create: (_) => CoddeState(project),
              ),
              Provider<CoddeEditorCubit>(
                create: (_) => CoddeEditorCubit(path: project.path),
              ),
            ],
            builder: (context, widget) {
              print('registered');
              bar.defineDestinations(context, [
                DynamicBarPager.controller,
                DynamicBarPager.editor,
                DynamicBarPager.dashboard,
                DynamicBarPager.terminal,
                DynamicBarPager.diagram,
              ]);
              return DynamicBar(
                nested: true,
                popNested: () => unregisterBackend(),
              );
            });
      },
    );
  }
}
