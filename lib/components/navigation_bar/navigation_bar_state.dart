import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/project_type.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'navigation_bar_state.g.dart';

class NavigationBarState = _NavigationBarState with _$NavigationBarState;

abstract class _NavigationBarState with Store {
  @observable
  int currentPage;
  @observable
  bool nested;

  // @observable
  @computed
  List<DynamicBarDestination> get destinations => nested
      ? [DynamicBarPager.controller, DynamicBarPager.community]
      : [DynamicBarPager.globalProjects, DynamicBarPager.community];
  @observable
  DynamicFab? fab;

  _NavigationBarState({this.currentPage = 0, this.nested = false});

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

  List<DynamicBarDestination> get projectMenu => [
        DynamicBarPager.controller,
        DynamicBarPager.editor,
        if (isRemoteProject) DynamicBarPager.dashboard,
        if (isRemoteProject) DynamicBarPager.terminal,
        DynamicBarPager.diagram,
      ];
  List<DynamicBarDestination> get homeMenu => [];

  @computed
  ObservableList<DynamicBarDestination> get paged {
    return ObservableList.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
  }

  // turn to ation since [pages] causes side effets
  @computed
  ObservableList<Widget> get pages {
    final list = ObservableList.of(
        paged.map<Widget>((e) => e.builtWidget ?? e.widget()).toList());
    return list;
  }

  @computed
  ObservableList<IconData> get icons {
    return ObservableList.of(paged.map<IconData>((e) => e.iconData).toList());
  }

  @action
  void setPage(DynamicBarDestination page) {
    currentPage = page.index;
    updateFab(page: currentPage);
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
  void updateFab({int page = 0}) {
    assert(destinations[page].builtWidget != null,
        'Widget should be built just before');
    print('update FAB');
    (destinations[page].builtWidget as dynamic)
        .setFab(navigatorKey.currentContext!);
  }
}
