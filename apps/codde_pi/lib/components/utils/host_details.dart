import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_overview/store/host_store.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/views/codde_card.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HostDetails extends StatelessWidget {
  Host? host;
  HostDetails({required this.host, super.key});

  final store = HostStore();
  @override
  Widget build(BuildContext context) {
    // final projectStore = Provider.of<CoddeState>(context);
    return host != null
        ? CoddeCard(
            child: Column(
              children: [
                // TODO: image of model
                Row(
                  children: [
                    const Text('Address:'),
                    Text("${host!.user}@${host!.addr}"),
                    IconButton(
                        onPressed: () {/* TODO: clipboard */},
                        icon: const Icon(Icons.copy))
                  ],
                ),
                Row(
                  children: [
                    const Text('Port:'),
                    Text((host!.port ?? '---').toString()),
                    IconButton(
                        onPressed: () {/* TODO: clipboard */},
                        icon: const Icon(Icons.copy))
                  ],
                ),
                /* Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // Do not add EDIT button here since th whole project is currently running based on the Host values
                  ElevatedButton(
                      onPressed: () {
                        GetIt.I.get<DynamicBarStore>().indexer_(
                            2); // <=> [Dashboard]. See [CoddeOverview.bottomMenu]
                      },
                      child: const Text('DASHBOARD')),
                ]), */
              ],
            ),
          )
        : Center(child: Text('No Host configured'));
// TODO: uploading project to remote (bad state managment and use case)
    /* ValueListenableBuilder<Box>(
            valueListenable: Hive.box<Project>(projectsBox)
                .listenable(keys: [projectStore.project.key]),
            builder: (context, box, widget) =>
                box.get(projectStore.project.key).host == null
                    ? Center(
                        child: ElevatedButton(
                        onPressed: () async {
                          final res = await showDialog(
                              context: context,
                              builder: (context) => SelectHostDialog(
                                  project: projectStore.project));
                          print("HOST ${res.$1}");
                          if (res.$1 != null && res.$2 != null) {
                            // projectStore.selectHost(host);
                            var project =
                                (box.get(projectStore.project.key) as Project)
                                  ..path = res.$2
                                  ..host = res.$1;
                            box.put(projectStore.project.key, project);
                            store.askCoddeReload();
                          }
                        },
                        child: const Text('SELECT HOST'),
                      ))
                    : Center(
                        child: ElevatedButton(
                            onPressed: () => reloadProject(
                                context, box.get(projectStore.project.key)),
                            child: Text('RELOAD')),
                      ),
          ); */
  }
}
