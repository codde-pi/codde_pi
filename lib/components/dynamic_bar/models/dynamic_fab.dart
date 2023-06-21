import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicFab extends Equatable {
  final IconData iconData;
  final Function? action;

  const DynamicFab({this.iconData = Icons.language, this.action});

  @override
  List<Object?> get props => [iconData, action];
}
