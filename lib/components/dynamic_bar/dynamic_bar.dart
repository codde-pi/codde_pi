import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class DynamicBar extends StatelessWidget {
  final bool nested;

  final List<DynamicBarDestination>? destinations;
  final int? startPage;

  const DynamicBar(
      {super.key, this.destinations, this.startPage, this.nested = false});

  @override
  Widget build(BuildContext context) {
    final bar = Provider.of<DynamicBarState>(context);
    // TODO: optional destinations and startPage
    return Scaffold(
      body: Observer(
        builder: (_) => IndexedStack(
            index: bar.currentPage,
            /* physics: const NeverScrollableScrollPhysics(), */
            children: bar.pages),
      ),
      bottomNavigationBar: Observer(
        builder: (_) => BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (nested) ...[
                RotatedBox(
                  quarterTurns: 2,
                  child: IconButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false),
                      icon: const Icon(Icons.logout)),
                ),
                const SizedBox(height: 24.0, child: VerticalDivider()),
              ],
              ...bar.paged.map((DynamicBarDestination e) => IconButton(
                  onPressed: () => bar.setPage(e), icon: Icon(e.iconData))),
              if (bar.fab != null)
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () =>
                          bar.fab!.action != null ? bar.fab!.action!() : {},
                      child: Icon(bar.fab!.iconData),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
