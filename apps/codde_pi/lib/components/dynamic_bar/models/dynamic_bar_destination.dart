import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicBarDestination extends Equatable {
  final IconData iconData;
  final String name;

  const DynamicBarDestination({required this.iconData, required this.name});

  @override
  List<Object?> get props => [iconData, name];

  @override
  operator ==(Object other) =>
      other is DynamicBarDestination &&
      other.iconData == iconData &&
      other.name == name;
}
