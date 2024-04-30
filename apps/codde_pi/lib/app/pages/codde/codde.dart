import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
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
      final backend = CoddeBackend(BackendLocation.local);
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
  void dispose() {
    unregisterBackend();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    return FutureBuilder(
      future: registerBackend(project: project),
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
        return MultiProvider(
            providers: [
              Provider<CoddeState>(
                create: (_) => CoddeState(project),
              ),
            ],
            builder: (context, widget) {
              return const DynamicBar(nested: true);
            });
      },
    );
  }
}