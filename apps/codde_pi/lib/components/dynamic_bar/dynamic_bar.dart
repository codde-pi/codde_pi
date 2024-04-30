export 'models/dynamic_fab.dart';
export 'models/dynamic_bar_menu.dart';
export 'models/dynamic_bar_pager.dart';
export 'models/dynamic_bar_widget.dart';
export 'models/dynamic_fab_selector.dart';
export 'models/dynamic_bar_destination.dart';
export 'store/dynamic_bar_store.dart';
export 'models/breadcrumb.dart';
export 'models/breadcrumb_tab.dart';

import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

/// Global App Navigation Widget
///
/// [nested] If `true`, define destinations of project session
/// [popNested_] Pass optional function to execute when exiting project session
/// [indexer_] Function calling specific action on bottom sheet menu item selection
class DynamicBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DynamicBar();
  final bool nested;
  final Function? popNested_;
  const DynamicBar({super.key, this.nested = false, this.popNested_});
}

class _DynamicBar extends State<DynamicBar> {
  late final DynamicBarStore bar;
  @override
  void initState() {
    bar = DynamicBarStore(nested: widget.nested);
    if (GetIt.I.isRegistered<DynamicBarStore>()) {
      GetIt.I.unregister<DynamicBarStore>();
    }
    GetIt.I.registerSingleton(bar);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bar.updateUI();
    });
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
      bottomNavigationBar: BottomAppBar(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Observer(
              builder: (context) => Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: navigatorKey.currentContext!,
                          useRootNavigator: true,
                          builder: (context) => SizedBox(
                            height: bar.menu.length *
                                    48.0 /* defaultButtonSize.height */ +
                                5 * widgetGutter +
                                48.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: widgetGutter),
                                  Center(
                                      child: Text(
                                    bar.nested ? "Menu" : "Actions",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )),
                                  const SizedBox(height: widgetGutter),
                                  const Divider(),
                                  const SizedBox(height: widgetGutter),
                                  ...(bar.menu)
                                      .asMap()
                                      .entries
                                      .map(
                                        (MapEntry<int, DynamicBarMenuItem> e) =>
                                            ListTile(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: widgetGutter,
                                                        right: widgetGutter),
                                                leading: Icon(e.value.iconData),
                                                title: Text(e.value.name),
                                                onTap: () {
                                                  bar.indexer_(e.key);
                                                  Navigator.of(context).pop();
                                                }),
                                      )
                                      .toList(),
                                ]),
                          ),
                        );
                      },
                      icon: const Icon(Icons.menu)),
                  ...bar.indexedDestinations.map(
                    (DynamicBarDestination e) => Padding(
                      padding: e.index != 0
                          ? const EdgeInsets.only(left: 0)
                          : const EdgeInsets.all(0),
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
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) => Container(
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
          ),
        ]),
      ),
    );
  }
}
