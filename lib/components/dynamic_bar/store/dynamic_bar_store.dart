import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/project_type.dart';
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
  @observable
  ProjectType? projectType;

  // @observable
  @computed
  List<DynamicBarDestination> get destinations => nested
      ? [
          projectType == ProjectType.controller
              ? DynamicBarPager.controller
              : DynamicBarPager.coddeOverview,
          DynamicBarPager.community
        ]
      : [DynamicBarPager.globalProjects, DynamicBarPager.community];
  @observable
  DynamicFab? fab;

  @observable
  List<DynamicBarMenuItem> menu = [];

  @observable
  late Function(int) indexer_ = (index) => selectMenuItem(index);

  @observable
  int menuIndex = 0;

  _DynamicBarStore(
      {this.currentPage = 0, this.nested = false, this.projectType});

  bool get isRemoteProject {
    if (GetIt.I.isRegistered<CoddeBackend>()) {
      return GetIt.I.get<CoddeBackend>().location == BackendLocation.server;
    }
    return false;
  }

  bool isProjectCdd(BuildContext context) {
    if (isInsideProject(context)) {
      return Provider.of<CoddeState>(context).project.type ==
          ProjectType.codde_pi;
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
    final list = ObservableList.of(indexedDestinations
        .map<Widget>((e) => applyMenuPage ?? (e.builtWidget ?? e.widget()))
        .toList());
    return list;
  }

  @computed
  ObservableList<IconData> get icons {
    return ObservableList.of(
        indexedDestinations.map<IconData>((e) => e.iconData).toList());
  }

  @computed
  Widget? get applyMenuPage {
    if (menuIndex != 0 && menu[menuIndex].destination != null) {
      return menu[menuIndex].destination!.builtWidget ??
          menu[menuIndex].destination!.widget();
    }
    return null;
  }

  @action
  void setPage(DynamicBarDestination page) {
    currentPage = page.index;
    menuIndex = 0;
    updateUI(page: currentPage);
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
  void updateUI({int page = 0}) {
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
  }

  @action
  void selectMenuItem(int index) {
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
}
