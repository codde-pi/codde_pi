import 'package:codde_pi/app/pages/codde/codde_diagram.dart';
import 'package:codde_pi/app/pages/devices/models/device_step.dart';
import 'package:codde_pi/app/pages/devices/views/device_playground.dart';
import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'views/device_collection.dart';
import 'views/device_garage.dart';

class Devices extends DynamicBarStatefulWidget {
  @override
  DynamicBarStateWidget<DynamicBarStatefulWidget> createDynamicState() =>
      _Devices();
}

class _Devices extends DynamicBarStateWidget<Devices> {
  late List<BreadCrumbTab> tabSteps = [
    BreadCrumbTab(name: "COLLECTION", widget: DeviceCollection()),
    BreadCrumbTab(name: "GARAGE", widget: null // ??=
        ),
    BreadCrumbTab(name: "PLAYGROUND", widget: null),
  ];

  // get tabMenu => bar.selectedBreadcrumbTab!.menu;
  // Widget Function(Object) get tabChild => bar.selectedBreadcrumbTab!.widget;

  @override
  List<DynamicBarMenuItem>? get bottomMenu {
    print('bottom menu = ${bar.selectedBreadcrumbTab!.widget!.bottomMenu}');
    return bar.selectedBreadcrumbTab!.widget!.bottomMenu;
  }

  @override
  void initState() {
    super.initState();
    bar.setBreadCrumb(tabSteps);
    bar.selectBreadcrumbTab(tabSteps.first);
  }

  @override
  void setFab(BuildContext context) {
    bar.selectedBreadcrumbTab!.widget!.setFab(context);
    /* bar.setFab(
        iconData: bar.selectedBreadcrumbTab!.fab.iconData,
        action: bar.selectedBreadcrumbTab!.fab.action ?? () => null); */
  }

  @override
  void setIndexer(BuildContext context) {
    bar.selectedBreadcrumbTab!.widget!.setIndexer(context);
    /* bar.setIndexer(bar.selectedBreadcrumbTab != null
        ? bar.selectedBreadcrumbTab!.indexer
        : (_) => null) */
  }

  /* String? get barTitle {
    switch (bar.breadCrumbTabArg.runtimeType) {
      case Device:
        return (bar.breadCrumbTabArg as Device).name;
      default:
        return null;
    }
  } */

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Observer(
      builder: (context) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              BreadCrumb(),
              Expanded(
                  child: bar.selectedBreadcrumbTab == null
                      ? const Text('Breadcrumb loading error')
                      : bar.breadCrumbWidget ?? // TODO:  integrate to dynamic_bar ?
                          const Text('Breadcrumb body error'))
            ],
          ),
        ),
      ),
    );
  }
}
