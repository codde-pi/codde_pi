import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_editor/codde_editor.dart' as editor;
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

class CoddeEditor extends editor.CoddeEditor implements DynamicBarWidget {
  @override
  get bar => GetIt.I.get<DynamicBarState>();
  @override
  void setFab(BuildContext context) {
    super.setFab(context);
  }
}
