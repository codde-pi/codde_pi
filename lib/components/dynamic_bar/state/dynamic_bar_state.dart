// contact.dart
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'dynamic_bar_state.g.dart';

class DynamicBarState = _DynamicBarState with _$DynamicBarState;

abstract class _DynamicBarState with Store {
  @observable
  ObservableList<DynamicBarDestination> destinations;
  @observable
  DynamicFab? fab;
  @observable
  int currentPage;

  _DynamicBarState(
      {required List<DynamicBarDestination> destinations,
      this.fab,
      this.currentPage = 0})
      : this.destinations = ObservableList.of(destinations);

  @computed
  ObservableList<DynamicBarDestination> get paged {
    return ObservableList.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
  }

  @computed
  ObservableList<Widget> get pages =>
      ObservableList.of(paged.map<Widget>((e) => e.widget).toList());

  @computed
  ObservableList<IconData> get icons {
    return ObservableList.of(paged.map<IconData>((e) => e.iconData).toList());
  }

  @action
  void setPage(DynamicBarDestination page) {
    currentPage = page.index;
  }

  @action
  void setFab({required IconData iconData, required Function action}) {
    fab = DynamicFab(iconData: iconData, action: action);
  }

  @action
  void defineDestinations(List<DynamicBarDestination> destinations) {
    this.destinations = ObservableList.of(destinations);
  }
}
