import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Update the bottom menu and the FAB dynamically when selected
/// [DynamicBarScaffold] is usually implemented in a section
/// (aka [DynamicBarDestination] page)
class DynamicFabScaffold extends StatefulWidget {
  final DynamicFab? fab;
  final Widget body;
  final DynamicBarDestination destination;

  // scaffold stuff
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final Widget? endDrawer;
  final String? restorationId;
  final void Function(bool)? onDrawerChanged;
  final void Function(bool)? onEndDrawerChanged;

  const DynamicFabScaffold(
      {this.fab,
      required this.destination,
      // scaffold stuff
      required this.body,
      this.appBar,
      /* this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator, */
      this.persistentFooterButtons,
      this.persistentFooterAlignment = AlignmentDirectional.centerStart,
      this.drawer,
      this.onDrawerChanged,
      this.endDrawer,
      this.onEndDrawerChanged,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.backgroundColor,
      this.resizeToAvoidBottomInset = true,
      this.primary = true,
      this.extendBody = false,
      this.extendBodyBehindAppBar = false,
      this.drawerScrimColor,
      this.drawerEdgeDragWidth,
      this.drawerEnableOpenDragGesture = true,
      this.endDrawerEnableOpenDragGesture = true,
      this.restorationId,
      super.key});

  @override
  State<DynamicFabScaffold> createState() => _DynamicBarScaffoldState();
}

class _DynamicBarScaffoldState extends State<DynamicFabScaffold> {
  late final provider =
      Provider.of<DynamicMenuNotifier>(context, listen: false);
  @override
  void initState() {
    updateFab(context, menuProvider: provider);
    provider.addListener(() {
      updateFab(context, menuProvider: provider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      persistentFooterButtons: widget.persistentFooterButtons,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,
      appBar: widget.appBar,
      body: Consumer<DynamicMenuNotifier>(
          builder: (context, provider, _) => widget.body),
    );
  }

  void updateFab(BuildContext context,
      {required DynamicMenuNotifier menuProvider}) {
    logger.d(
        '${widget.destination.name}: ${menuProvider.isCurrentPage(widget.destination)}');
    if (menuProvider.isCurrentPage(widget.destination)) {
      setFab(context: context, fab: widget.fab);
    }
  }
}
