import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class BreadCrumb extends StatelessWidget {
  late DynamicBarStore bar;

  @override
  Widget build(BuildContext context) {
    bar = GetIt.I.get<DynamicBarStore>();
    return Observer(
      builder: (context) => Row(
        mainAxisSize: MainAxisSize.max,
        children: bar.breadCrumbTabs
            .takeWhile((value) =>
                bar.selectedBreadcrumbTab == null ||
                bar.breadCrumbTabs.indexOf(value) <=
                    bar.breadCrumbTabs.indexOf(bar.selectedBreadcrumbTab!))
            .map((e) => TextButton(
                  child: Text("${e.name} /"),
                  onPressed: () => bar.selectBreadcrumbTab(e),
                ))
            .toList(),
      ),
    );
  }
}
