import 'package:codde_pi/app/pages/soon/soon.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Soon(title: "Dashboard"),
    );
  }
}
