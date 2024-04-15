import 'package:codde_pi/app/pages/soon/soon.dart';
import 'package:flutter/material.dart';

class Community extends Soon {
  Community({super.key}) : super(title: "Community");

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: super.build(context) //Soon(title: "Community"),
        );
  }
}
