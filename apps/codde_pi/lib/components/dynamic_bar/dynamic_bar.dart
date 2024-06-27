// ignore_for_file: curly_braces_in_flow_control_structures

export 'models/dynamic_fab.dart';
export 'models/dynamic_bar_menu.dart';
export 'models/dynamic_bar_pager.dart';
export 'models/dynamic_bar_destination.dart';
export 'store/dynamic_bar_notifier.dart';
export 'store/utils.dart';
export 'models/breadcrumb.dart';
export 'models/dynamic_bar_scaffold.dart';
export 'models/dynamic_fab_scaffold.dart';

import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Global App Navigation Widget
///
/// [nested] If `true`, define destinations of project workspace
/// [popNested_] Pass optional function to execute when exiting project session
/// [indexer_] Function calling specific action on bottom sheet menu item selection
class DynamicBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DynamicBar();
  final bool nested;
  final Function? popNested_;
  final List<Widget>? children;
  final List<DynamicBarDestination> pagers;
  Widget? child;
  DynamicBar(
      {super.key,
      this.nested = false,
      this.popNested_,
      required this.pagers,
      this.children,
      this.child});
}

class _DynamicBar extends State<DynamicBar> {
  late final sectionProvider = DynamicSectionNotifier(widget.pagers);
  late final menuProvider = DynamicMenuNotifier();
  late final fabProvider = DynamicFabNotifier();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // notify [DynamicBarScaffold] listener
      //  loading menu + fab for the specified index
      sectionProvider.selectSection(0);
    });
  }

  @override
  void dispose() {
    if (widget.popNested_ != null) widget.popNested_!(); // TODO: useful ?
    super.dispose();
  }

  // Color? get backgroundColor => widget.nested ? Colors.blue.darken(0.75) : null;

  @override
  Widget build(BuildContext context) {
    assert(widget.children != null || widget.child != null,
        'Either children or child must be set');
    if (widget.children != null)
      assert(widget.pagers.length == widget.children!.length,
          'Pagers and children counts are incorrect');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sectionProvider),
        ChangeNotifierProvider(create: (_) => fabProvider),
        ChangeNotifierProvider(create: (_) => menuProvider),
      ],
      builder: (context, _) => Scaffold(
        body: Consumer<DynamicSectionNotifier>(
          builder: (context, sP, _) => widget.children != null
              ? IndexedStack(
                  index: sP.currentSection,
                  /* physics: const NeverScrollableScrollPhysics(), */
                  children: widget.children!,
                )
              : widget.child!,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: Consumer<DynamicSectionNotifier>(
                builder: (context, sP, _) => Row(
                  children: [
                    Consumer<DynamicMenuNotifier>(
                      builder: (context, p, _) => IconButton(
                          onPressed: p.menu == null
                              ? null
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    builder: (context) => SizedBox(
                                      height: p.menu!.length *
                                              48.0 /* defaultButtonSize.height */ +
                                          5 * widgetGutter +
                                          48.0,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                                height: widgetGutter),
                                            Center(
                                                child: Text(
                                              "Menu",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )),
                                            const SizedBox(
                                                height: widgetGutter),
                                            const Divider(),
                                            const SizedBox(
                                                height: widgetGutter),
                                            ...(p.menu!).asMap().entries.map(
                                                  (MapEntry<int, DynamicBarMenuItem>
                                                          e) =>
                                                      ListTile(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                      widgetGutter,
                                                                  right:
                                                                      widgetGutter),
                                                          leading: Icon(
                                                              e.value.destination
                                                                  .iconData),
                                                          title: Text(e
                                                              .value
                                                              .destination
                                                              .name),
                                                          onTap: () {
                                                            logger.d(
                                                                "click ${e.value.destination.name}");
                                                            menuProvider
                                                                .selectMenuItem(
                                                                    context,
                                                                    e.key);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                )
                                          ]),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.menu)),
                    ),
                    ...sP.destinations.asMap().entries.map(
                          (MapEntry<int, DynamicBarDestination> e) => Padding(
                            padding: e.key != 0
                                ? const EdgeInsets.only(left: 0)
                                : const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    sectionProvider.selectSection(e.key);
                                  },
                                  isSelected: sP.currentSection == e.key,
                                  icon: Icon(e.value.iconData),
                                ),
                                Visibility(
                                  visible: sP.currentSection == e.key,
                                  child: Text(
                                    e.value.name.toUpperCase(),
                                    style: const TextStyle(color: accent),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                  ],
                ),
              ),
            ),
            Consumer<DynamicFabNotifier>(
              builder: (context, p, _) => Container(
                  alignment: Alignment.centerRight,
                  child: p.fab == null
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
                          onPressed: () async => p.fab!.action != null
                              ? await p.fab!.action!()
                              : null,
                          child: Icon(p.fab!.iconData),
                        )),
            ),
          ]),
        ),
      ),
    );
  }
}
