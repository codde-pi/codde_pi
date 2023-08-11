import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

mixin DynamicFabSelector {
  DynamicBarState get bar => GetIt.I.get<DynamicBarState>();
  final ValueNotifier<BuildContext?> built = ValueNotifier(null);

  void setFab(BuildContext context);

  void fabOnceBuilt(BuildContext context) {
    if (built.value != null) {
      setFab(context);
      built.removeListener(() {});
    } else {
      built.addListener(() {
        setFab(context);
      });
    }
  }
}
