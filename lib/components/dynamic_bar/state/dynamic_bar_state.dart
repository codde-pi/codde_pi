// contact.dart
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:codde_pi/main.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'dynamic_bar_state.g.dart';

class DynamicBarState = _DynamicBarState with _$DynamicBarState;
/* class DynamicBarState extends _DynamicBarState with _$DynamicBarState {
  DynamicBarState(
      {required List<DynamicBarDestination> destinations,
      super.fab,
      super.currentPage = 0,
      super.previousDestinations})
      : super(destinations: ObservableList.of(destinations));

  factory DynamicBarState.initFab(
      {required BuildContext context,
      required List<DynamicBarDestination> destinations,
      int currentPage = 0}) {
    final instance =
        DynamicBarState(destinations: destinations, currentPage: currentPage);
    (destinations[currentPage].widget as DynamicFabSelector).setFab(context);
    return instance;
  }
} */

abstract class _DynamicBarState with Store {
  @observable
  ObservableList<DynamicBarDestination> destinations;
  @observable
  ObservableList<DynamicBarDestination>? previousDestinations;
  @observable
  DynamicFab? fab;
  @observable
  int currentPage;

  _DynamicBarState(
      {required List<DynamicBarDestination> destinations,
      this.fab,
      this.currentPage = 0,
      this.previousDestinations})
      : this.destinations = ObservableList.of(destinations);

  @computed
  ObservableList<DynamicBarDestination> get paged {
    return ObservableList.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
  }

  // turn to ation since [pages] causes side effets
  @action
  ObservableList<Widget> pages() {
    final list = ObservableList.of(
        paged.map<Widget>((e) => e.builtWidget ?? e.widget()).toList());
    updateFab();
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
    (destinations[page].builtWidget as dynamic)
        .setFab(navigatorKey.currentContext!);
  }

  @action
  void defineDestinations(
      BuildContext context, List<DynamicBarDestination> destinations) {
    this.previousDestinations = this.destinations;
    this.destinations = ObservableList.of(destinations);
    // updateFab();
  }
}

class DestinationException {}
