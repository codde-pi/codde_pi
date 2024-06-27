import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreadCrumbScaffold extends StatelessWidget {
  final List<DynamicBarDestination> tabs;
  final DynamicBreadNotifier provider;
  final Widget initialStep;
  BreadCrumbScaffold({super.key, required this.tabs, required this.initialStep})
      : provider = DynamicBreadNotifier([initialStep]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => provider,
      lazy: false,
      builder: (context, _) => PopScope(
        canPop: false,
        onPopInvoked: (_) {
          final index = provider.currentStep;
          if (index == 0) {
            // Navigator.of(context).pop();
          } else {
            provider.selectStep(index > 0 ? index - 1 : 0);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Consumer<DynamicBreadNotifier>(
                  builder: (context, p, _) => Row(
                    mainAxisSize: MainAxisSize.max,
                    children: tabs
                        .take(p.currentStep + 1)
                        .map((e) => TextButton(
                              child: Text("${e.name} /"),
                              onPressed: () =>
                                  selectStep(context, tabs.indexOf(e), e),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: Consumer<DynamicBreadNotifier>(
                    builder: (context, p, _) =>
                        IndexedStack(index: p.currentStep, children: p.steps),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
