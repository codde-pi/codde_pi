import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

mixin DynamicFabSelector {
  get bar => GetIt.I.get<DynamicBarState>();
  setFab(BuildContext context);
}
