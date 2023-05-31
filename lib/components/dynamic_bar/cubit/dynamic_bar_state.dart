import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@Deprecated("Replaced by GetX state management")
class DynamicBarState extends Equatable {
  final List<DynamicBarDestination> destinations;
  final DynamicFab? fab;
  final int currentPage;

  const DynamicBarState(
      {required this.destinations, this.fab, this.currentPage = 0});

  List<DynamicBarDestination> get paged {
    List<DynamicBarDestination> list = List.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  List<Widget> get pages {
    List list = paged;
    return list.map<Widget>((e) => e.widget).toList();
  }

  List<IconData> get icons {
    List list = paged;
    return list.map<IconData>((e) => e.iconData).toList();
  }

  DynamicBarState copyWith(
      {List<DynamicBarDestination>? destinations,
      DynamicFab? fab,
      int? currentPage}) {
    return DynamicBarState(
        destinations: destinations ?? this.destinations,
        fab: fab ?? this.fab,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [destinations, fab];
}
