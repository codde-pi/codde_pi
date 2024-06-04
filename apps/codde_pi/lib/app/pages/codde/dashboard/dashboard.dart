import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/dashboard/api/dashboard_commands.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/select_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'api/dashboard_data.dart';
import 'store/dashboard_store.dart';
import 'views/cards.dart';

class Dashboard extends DynamicBarStatefulWidget {
  Dashboard({super.key});

  @override
  DynamicBarState<DynamicBarStatefulWidget> createDynamicState() {
    return _Dashboard();
  }
}

class _Dashboard extends DynamicBarState<Dashboard> {
  final store = DashboardStore();
  late final DashboardCommands dbd = DashboardCommands();

  CoddeBackend get backend => GetIt.I<CoddeBackend>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final projectStore = Provider.of<CoddeState>(context);
    return Scaffold(
        appBar: null,
        body: Observer(builder: (_) {
          if (projectStore.project.device.host == null) {
            return Center(
                child: SelectDeviceDialog(
              onlyHosts: true,
            )); // TODO: button navigation instead?
          }

          if (backend.client == null) {
            return const Center(child: Text('No connection'));
          }
          return SafeArea(
              child: StreamBuilder<DashboardData?>(
            stream: dbd.streamCommands(),
            builder: (context, snapshot) {
              //print('stream is listened');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                    child: Text('Error ')); //${snapshot.error ?? ""}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('Nodata'));
              } else {
                final DashboardData data = snapshot.data!;
                /* data = json
                                    .decode(snapshot.data.toString())['data']; */

                return StaggeredGrid.count(
                  /*physics: NeverScrollableScrollPhysics(),*/
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: <StaggeredGridTile>[
                    StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CardVoltage(data.voltage)),
                    StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CardCpu(cpu: data.cpu)),
                    StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CardMem(data.mem)),
                    StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CardDisk(data.disk)),
                    /* StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: CardTemp(
                          data.temp,
                        )), */
                    StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: CardTasks(data.tasks)),
                  ],
                );
              }
            },
          ));
        }));
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
