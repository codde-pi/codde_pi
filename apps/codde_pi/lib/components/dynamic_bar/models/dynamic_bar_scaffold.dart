import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicBarScaffold extends StatelessWidget {
  final List<DynamicBarMenuItem> pages;
  final bool Function(BuildContext, int)? indexer;
  final Widget? body;
  const DynamicBarScaffold(
      {this.body, required this.pages, this.indexer, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DynamicBarNotifier>(context, listen: false);
    provider.addListener(() { });
    provider.setMenuList(menuList: pages, indexer: indexer);

    return Consumer<DynamicBarNotifier>(
        builder: (context, provider, _) =>
            body ??
            IndexedStack(
              index: provider.currentMenuItem,
              children: DynamicBarNotifier.menuPages(pages)!,
            ));
  }
}
