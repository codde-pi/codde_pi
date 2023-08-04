import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class DynamicBar extends StatelessWidget {
  final bool nested;

  final List<DynamicBarDestination>? destinations;
  final int? startPage;
  final Function? popNested;
  final bar = GetIt.I.get<DynamicBarState>();

  DynamicBar(
      {super.key,
      this.destinations,
      this.startPage,
      this.nested = false,
      this.popNested});

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        if (bar.previousDestinations == null) {
                          throw DestinationException();
                        }
                        bar.defineDestinations(bar.previousDestinations!);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                        if (popNested != null) popNested!();
                      },
                      icon: const Icon(Icons.logout)),
                ),
                const SizedBox(height: 24.0, child: VerticalDivider()),
              ],
              ...bar.paged.map(
                (DynamicBarDestination e) => Padding(
                  padding: const EdgeInsets.only(left: widgetGutter),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => bar.setPage(e),
                        isSelected: bar.currentPage == e.index,
                        icon: Icon(e.iconData),
                      ),
                      Visibility(
                        visible: bar.currentPage == e.index,
                        child: Text(
                          e.name.toUpperCase(),
                          style: const TextStyle(color: accent),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (bar.fab != null)
                Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: bar.fab == null
                          ? null
                          : /* bar.fab!.extended == null
                        ? FloatingActionButton(
                            onPressed: () => bar.fab!.action != null
                                ? bar.fab!.action!()
                                : {},
                            child: Icon(bar.fab!.iconData),
                          )
                        : Row(mainAxisSize: MainAxisSize.min, children: [
                            bar.fab!.extended!,
                            FloatingActionButton(
                                onPressed: bar.fab!.action != null
                                    ? bar.fab!.action!()
                                    : {},
                                child: Icon(bar.fab!.iconData)),
                          ]), */
                          FloatingActionButton(
                              onPressed: () => bar.fab!.action != null
                                  ? bar.fab!.action!()
                                  : {},
                              child: Icon(bar.fab!.iconData),
                            )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
