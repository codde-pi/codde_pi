import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicBarDestination extends Equatable {
  final int index;
  final IconData iconData;
  final String name;

  const DynamicBarDestination(
      {required this.index, required this.iconData, required this.name});

  @override
  List<Object?> get props => [index, iconData, name];

  @override
  operator ==(Object other) =>
      other is DynamicBarDestination &&
      other.index == index &&
      other.iconData == iconData &&
      other.name == name;
}
