import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

mixin DynamicFabSelector {
  DynamicBarStore get bar => GetIt.I.get<DynamicBarStore>();
  final ValueNotifier<BuildContext?> built = ValueNotifier(null);

  void setFab(BuildContext context);

  List<DynamicBarMenuItem>? get bottomMenu;

  void setIndexer();

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

  void setMenu() => bottomMenu != null ? bar.setMenu(bottomMenu!) : null;
}
