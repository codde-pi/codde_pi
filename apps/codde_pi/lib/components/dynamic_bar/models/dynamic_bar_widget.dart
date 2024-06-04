import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// TODO: use it instead of [Widget]
abstract class DynamicBarWidget extends Widget with DynamicFabSelector {}

abstract class DynamicBarStatelessWidget extends StatelessWidget
    with DynamicFabSelector {
  DynamicBarStatelessWidget({super.key});
  @override
  @mustCallSuper
  @mustBeOverridden
  Widget build(BuildContext context) {
    built.value = context;
    return Container();
  }
  // TODO: add built value listener in setFab (for StatelessWidget) ?
}

enum WaitForAction { setFab, setMenu, setIndexer }

abstract class DynamicBarStatefulWidget extends StatefulWidget
    with DynamicFabSelector {
  DynamicBarStatefulWidget({super.key});
  final ValueNotifier<DynamicBarState?> _state = ValueNotifier(null);
  void waitForState(WaitForAction action, [dynamic arg]) {
    if (_state.value != null) {
      _callAction(action, arg);
      _state.removeListener(() {});
    } else {
      _state.addListener(() {
        _callAction(action, arg);
      });
    }
  }

  void _callAction(WaitForAction action, [dynamic arg]) {
    switch (action) {
      case WaitForAction.setFab:
        return _state.value!.setFab(arg);
      case WaitForAction.setMenu:
        return _state.value!.setMenu();
      case WaitForAction.setIndexer:
        return _state.value!.setIndexer(arg);
    }
  }

  @override
  setFab(BuildContext context) {
    waitForState(WaitForAction.setFab, context);
  }

  @override
  setMenu() {
    waitForState(WaitForAction.setMenu);
  }

  @override
  setIndexer(context) {
    waitForState(WaitForAction.setIndexer, context);
  }

  @override
  get bottomMenu => _state.value!.bottomMenu;

  @override
  State<StatefulWidget> createState() {
    _state.value = createDynamicState();
    return _state.value!;
  }

  DynamicBarState createDynamicState();
}

abstract class DynamicBarState<T extends DynamicBarStatefulWidget>
    extends State<T> with DynamicFabSelector {
  @override
  @mustCallSuper
  @mustBeOverridden
  Widget build(BuildContext context) {
    widget.built.value = context;
    return Container();
  }
}
