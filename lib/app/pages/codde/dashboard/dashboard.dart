import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/select_host_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'store/dashboard_store.dart';

class CoddeHost extends DynamicBarWidget {
  CoddeHost({super.key});
  final store = CoddeHostStore();

  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<CoddeState>(context);
    return Scaffold(
      appBar: null,
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box<Project>(projectsBox)
            .listenable(keys: [projectStore.project.key]),
        builder: (context, box, widget) => box
                    .get(projectStore.project.key)
                    .host ==
                null
            ? Center(
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      final res = await showDialog(
                          context: context,
                          builder: (context) =>
                              SelectHostDialog(project: projectStore.project));
                      print("HOST ${res.$1}");
                      if (res.$1 != null && res.$2 != null) {
                        // projectStore.selectHost(host);
                        var _project =
                            (box.get(projectStore.project.key) as Project)
                              ..path = res.$2
                              ..host = res.$1;
                        box.put(projectStore.project.key, _project);
                        store.askCoddeReload();
                      }
                    },
                    label: const Text('Select Host'),
                    icon: const Icon(Icons.add)))
            : Observer(
                builder: (context) => store.needCoddeReload
                    ? Center(
                        child: FloatingActionButton.extended(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed("/codde",
                                  arguments: box.get(projectStore.project.key)),
                          label: const Text('RELOAD PROJECT'),
                          icon: const Icon(Icons.refresh_outlined),
                        ),
                      )
                    : const SafeArea(
                        child: Text("Host details / dashboard"),
                      ),
              ),
      ),
    );
  }

  @override
  setFab(BuildContext context) {
    bar.disableFab();
  }

  @override
  void setIndexer(context) {}

  @override
  List<DynamicBarMenuItem>? get bottomMenu => null;
}
