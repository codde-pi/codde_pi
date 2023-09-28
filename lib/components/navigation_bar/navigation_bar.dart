import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'navigation_bar_state.dart';

class NavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationBar();
  final Function? popNested_;
  const NavigationBar({super.key, this.popNested_});
}

class _NavigationBar extends State<NavigationBar> {
  final bar = NavigationBarState();
  @override
  void initState() {
    GetIt.I.registerSingleton(bar);
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I.unregister(instance: bar);
    if (widget.popNested_ != null) widget.popNested_!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => IndexedStack(
          index: bar.currentPage,
          /* physics: const NeverScrollableScrollPhysics(), */
          children: bar.pages,
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => BottomAppBar(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: (bar.isInsideProject(context)
                                  ? bar.projectMenu
                                  : bar.homeMenu)
                              .map(
                                (DynamicBarDestination e) => ListTile(
                                    leading: Icon(e.iconData),
                                    title: Text(e.name),
                                    onTap: () => bar.setPage(e)),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.menu)),
            ...bar.paged.map(
              (DynamicBarDestination e) => Padding(
                padding:
                    e.index != 0 ? EdgeInsets.only(left: 0) : EdgeInsets.all(0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        bar.setPage(e);
                      },
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
              Container(
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
                          onPressed: () =>
                              bar.fab!.action != null ? bar.fab!.action!() : {},
                          child: Icon(bar.fab!.iconData),
                        )),
          ]),
        ),
      ),
    );
  }
}