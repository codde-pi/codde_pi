import 'dart:ui';

import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_controller_event.dart';
part 'edit_controller_state.dart';

class EditControllerBloc
    extends Bloc<EditControllerEvent, EditControllerState> {
  EditControllerBloc({
    required this.repo,
    required ControllerMap map,
  }) : super(EditControllerState(map: map)) {
    on<EditControllerSubscriptionRequested>(_onSubscriptionRequested);
    on<ControllerWidgetAdded>(_widgetAdded);
    on<ControllerWidgetRemoved>(_widgetRemoved);
    on<ControllerWidgetClicked>(_widgetClicked);
    on<ControllerWidgetLongTaped>(_widgetLongTaped);
    on<ControllerWidgetCanceled>(_widgetCanceled);
    on<ControllerWidgetSelectedCanceled>(_widgetSelectedCanceled);
  }

  final ControllerWidgetRepository repo;

  Future<void> _onSubscriptionRequested(
    EditControllerSubscriptionRequested event,
    Emitter<EditControllerState> emit,
  ) async {
    emit(state.copyWith(status: ControllerStatus.loading));

    await emit.forEach<List<ControllerWidget>>(
      repo.getWidgets(),
      onData: (event) {
        Map<int, ControllerWidget> map = {};
        event.forEach((element) {
          map[element.id] = element;
        });
        return state.copyWith(
          status: ControllerStatus.loading,
          widgets: map,
        );
      },
      onError: (_, __) => state.copyWith(
        status: ControllerStatus.failure,
      ),
    );
  }

  void _widgetAdded(ControllerWidgetAdded event, emit) {
    emit(state.addWidget(event.widget));
  }

  void _widgetRemoved(ControllerWidgetRemoved event, emit) {
    emit(state.removeWidget(event.id));
  }

  void _widgetClicked(ControllerWidgetClicked event, emit) {
    emit(state.copyWith(showDetails: event.id));
  }

  void _widgetLongTaped(ControllerWidgetLongTaped event, emit) {
    emit(state.copyWith(movable: event.id));
  }

  void _widgetCanceled(ControllerWidgetCanceled event, emit) {
    emit(state.copyWith(movable: 0, showDetails: 0));
  }

  void _widgetSelectedCanceled(ControllerWidgetSelectedCanceled event, emit) {
    if (event.id != state.showDetails && event.id != state.movable) return;
    emit(state.copyWith(
        movable: event.id == state.movable ? 0 : state.movable,
        showDetails: event.id == state.showDetails ? 0 : state.showDetails));
  }
}
