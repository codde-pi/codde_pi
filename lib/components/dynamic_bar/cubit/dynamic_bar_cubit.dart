import 'package:bloc/bloc.dart';
import 'package:codde_pi/components/dynamic_bar/cubit/dynamic_bar_state.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:flutter/widgets.dart';

class DynamicBarCubit extends Cubit<DynamicBarState> {
  DynamicBarCubit({required pager}) : super(DynamicBarState(pager: pager));

  void setPage(PageController pageController, DynamicBarDestination page) {
    pageController.jumpToPage(page.index);
  }

  void setFab(IconData iconData, Function action) {
    emit(state.copyWith(fab: DynamicFab(iconData: iconData, action: action)));
  }
}
