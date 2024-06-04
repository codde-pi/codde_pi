import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'dynamic_bar_store.g.dart';

class DynamicBarStore = _DynamicBarStore with _$DynamicBarStore;

abstract class _DynamicBarStore with Store {
  @observable
  int currentPage;
  @observable
  bool nested;

  @computed
  List<DynamicBarDestination> get destinations => [
        nested
            ? DynamicBarPager.coddeOverview(
                instance: CoddeOverview()) // TODO: improve syntax
            : DynamicBarPager.globalProjects,
        DynamicBarPager.community,
        DynamicBarPager.devices
      ];
  @observable
  DynamicFab? fab;

  @observable
  List<DynamicBarMenuItem> menu = [];

  @observable
  late Function(int) indexer_ = (index) => selectMenuItem(index);

  @observable
  int menuIndex = 0;

  _DynamicBarStore({this.currentPage = 0, this.nested = false});

  bool get isRemoteProject {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      return GetIt.I.get<CoddeBackend>().location == BackendLocation.server;
    }
    return false;
  }

  bool isInsideProject(BuildContext context) =>
      (Provider.of<CoddeState>(context).runtimeType == Project);

  /* @action
  void goIntoProject() {
    destinations = [DynamicBarPager.controller, DynamicBarPager.community];
  } */

  @computed
  ObservableList<DynamicBarDestination> get indexedDestinations {
    return ObservableList.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
  }

  /// For each page, display Page 0 only if menuIndex 0 is selected
  /// or menuIndex doesn't correspond to any widget
  @computed
  ObservableList<Widget> get pages {
    final List<Widget> list =
        indexedDestinations.map<Widget>((e) => getWidget(e)!).toList();
    list[0] = applyMenuPage ?? list[0];
    return ObservableList.of(list);
  }

  Widget? getWidget(e) => e?.builtWidget ?? e?.widget();

  @computed
  ObservableList<IconData> get icons {
    return ObservableList.of(
        indexedDestinations.map<IconData>((e) => e.iconData).toList());
  }

  @computed
  Widget? get applyMenuPage {
    if (menuIndex != 0 && menu[menuIndex].destination != null) {
      print('returning widget');
      return getWidget(menu[menuIndex].destination);
    }
    print('returning null');
    return null;
  }

  @action
  void setPage(DynamicBarDestination page) {
    currentPage = page.index;
    menuIndex = 0;
    updateUI();
  }

  @action
  void setFab(
      {required IconData iconData,
      required Function action,
      IconButton? extended}) {
    fab = DynamicFab(
      iconData: iconData,
      action: action,
      extended: extended,
    );
  }

  @action
  disableFab() {
    fab = null;
  }

  @action
  void updateUI({int? page}) {
    page = page ?? currentPage;
    assert(destinations[page].builtWidget != null,
        'Widget should be built just before');
    // set Fab
    (destinations[page].builtWidget as dynamic)
        .setFab(navigatorKey.currentContext!);
    // set Menu
    (destinations[page].builtWidget as dynamic).setMenu();
    // set Indexer
    (destinations[page].builtWidget as dynamic)
        .setIndexer(navigatorKey.currentContext!);
    // TODO: set BreadcrumbTab ?
  }

  @action
  void selectMenuItem(int index) {
    print('select menu item $index');
    menuIndex = index;
  }

  @action
  void setMenu(List<DynamicBarMenuItem> menu) {
    this.menu = menu;
  }

  @action
  void setIndexer(Function(int) indexer) {
    indexer_ = (index) {
      selectMenuItem(index);
      indexer(index);
    };
  }

  @observable
  List<BreadCrumbTab> breadCrumbTabs = [];

  @observable
  BreadCrumbTab? selectedBreadcrumbTab;

  @action
  setBreadCrumb(List<BreadCrumbTab> breadcrumbTabs) {
    breadCrumbTabs = breadcrumbTabs;
  }

  @action
  void selectBreadcrumbTab(BreadCrumbTab e,
      {DynamicBarStatefulWidget? widget}) {
    if (widget != null) e.widget = widget;
    selectedBreadcrumbTab = e;
    selectMenuItem(0);
    updateUI();
  }

  /* @observable
  dynamic breadCrumbTabArg; */

  /* @action
  setBreadcrumbTabArg(dynamic e) {
    breadCrumbTabArg = e;
  } */

  @computed
  Widget? get breadCrumbWidget {
    return applyMenuPage ?? selectedBreadcrumbTab!.widget;
  }
}
