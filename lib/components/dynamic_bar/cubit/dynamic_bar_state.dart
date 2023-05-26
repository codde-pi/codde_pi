import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicBarState extends Equatable {
  final List<DynamicBarDestination> pager;
  final DynamicFab? fab;

  const DynamicBarState({required this.pager, this.fab});

  List<DynamicBarDestination> get paged {
    List<DynamicBarDestination> list = List.of(pager)
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
      {List<DynamicBarDestination>? pager, DynamicFab? fab}) {
    return DynamicBarState(pager: pager ?? this.pager, fab: fab ?? this.fab);
  }

  @override
  List<Object?> get props => [pager, fab];
}
