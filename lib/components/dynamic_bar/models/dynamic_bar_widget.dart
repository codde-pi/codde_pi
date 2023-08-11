import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class DynamicBarWidget extends StatelessWidget
    with DynamicFabSelector {
  DynamicBarWidget({super.key});
  @override
  @mustCallSuper
  @mustBeOverridden
  Widget build(BuildContext context) {
    built.value = context;
    return Container();
  }
  // TODO: add built value listener in setFab (for StatelessWidget) ?
}

abstract class DynamicBarStatefulWidget extends StatefulWidget
    with DynamicFabSelector {
  DynamicBarStatefulWidget({super.key});
  final ValueNotifier<DynamicBarStateWidget?> _state = ValueNotifier(null);
  void waitForState(BuildContext context) {
    print('${runtimeType} waitForState');
    if (_state.value != null) {
      print('$runtimeType state not null');
      _state.value!.setFab(context);
      _state.removeListener(() {});
    } else {
      _state.addListener(() {
        print('${runtimeType} setFab');
        // print('${runtimeType} = ${state.value != null}');
        _state.value?.setFab(context);
      });
    }
  }

  @override
  setFab(BuildContext context) {
    waitForState(context);
  }

  @override
  State<StatefulWidget> createState() {
    _state.value = createDynamicState();
    return _state.value!;
  }

  DynamicBarStateWidget createDynamicState();
}

abstract class DynamicBarStateWidget<T extends DynamicBarStatefulWidget>
    extends State<T> with DynamicFabSelector {
  @override
  @mustCallSuper
  @mustBeOverridden
  Widget build(BuildContext context) {
    widget.built.value = context;
    return Container();
  }
}
