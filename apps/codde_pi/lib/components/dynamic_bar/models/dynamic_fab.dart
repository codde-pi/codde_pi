import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicFab extends Equatable {
  final IconData iconData;
  final Function? action;
  final IconButton? extended;

  const DynamicFab(
      {this.iconData = Icons.language, this.action, this.extended});

  @override
  List<Object?> get props => [iconData, action, extended];
}
