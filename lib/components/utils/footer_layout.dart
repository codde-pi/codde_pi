import 'package:flutter/material.dart';

class FooterLayout extends StatelessWidget {
  Widget child;
  Widget footer;
  FooterLayout({required this.child, required this.footer});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: child), footer],
    );
  }
}
