import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class CoddeCard extends StatelessWidget {
  final Widget child;
  const CoddeCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
        child:
            Padding(padding: const EdgeInsets.all(widgetGutter), child: child));
  }
}
