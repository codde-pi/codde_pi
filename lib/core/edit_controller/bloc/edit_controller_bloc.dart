import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_controller_event.dart';
part 'edit_controller_state.dart';

class EditControllerBloc
    extends Bloc<EditControllerEvent, EditControllerState> {
  EditControllerBloc({
    required this.repo,
  }) : super(const EditControllerState()) {
    on<ControllerWidgetSubscribed>(_onWidgetSubscribed);
    on<ControllerMapSubscribed>(_onMapSubscribed);
    on<ControllerWidgetAdded>(_widgetAdded);
    on<ControllerLayerParsed>(_layerParsed);
    on<ControllerWidgetRemoved>(_widgetRemoved);
    on<ControllerWidgetClicked>(_widgetClicked);
    on<ControllerWidgetLongTaped>(_widgetLongTaped);
    on<ControllerWidgetCanceled>(_widgetCanceled);
    on<ControllerWidgetSelectedCanceled>(_widgetSelectedCanceled);
    on<ControllerWidgetMoved>(_widgetMoved);
    on<ControllerMapSaved>(_mapSaved);
  }

  final ControllerWidgetRepository repo;

  Future<void> _onWidgetSubscribed(
    ControllerWidgetSubscribed event,
    Emitter<EditControllerState> emit,
  ) async {
    emit(state.copyWith(status: ControllerStatus.loading));

    await emit.forEach<Map<int, ControllerWidget>>(
      repo.streamWidgets(),
      onData: (event) {
        return state.copyWith(
          status: ControllerStatus.success,
          widgets: event,
        );
      },
      onError: (_, __) => state.copyWith(
        status: ControllerStatus.failure,
      ),
    );
  }

  Future<void> _onMapSubscribed(
    ControllerMapSubscribed event,
    Emitter<EditControllerState> emit,
  ) async {
    emit(state.copyWith(status: ControllerStatus.loading));

    await emit.forEach<ControllerMap>(
      repo.streamMap(),
      onData: (event) {
        return state.copyWith(
          status: ControllerStatus.success,
          map: event,
        );
      },
      onError: (_, __) => state.copyWith(
        status: ControllerStatus.failure,
      ),
    );
  }

  void _widgetAdded(ControllerWidgetAdded event, emit) {
    repo.addWidget(event.widget);
    emit(state.edit());
  }

  void _layerParsed(ControllerLayerParsed event, emit) {
    repo.parseLayers(event.layers);
  }

  void _widgetMoved(ControllerWidgetMoved event, emit) {
    repo.modifyWidget(
        state.widgets[event.id]!.copyWith(x: event.x, y: event.y));
    emit(state.edit());
  }

  void _widgetRemoved(ControllerWidgetRemoved event, emit) {
    final removedWidget = repo.removeWidget(event.id);
    emit(state.copyWith(lastDeletedWidget: removedWidget));
    emit(state.edit());
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

  void _mapSaved(ControllerMapSaved event, emit) {
    repo.saveMap();
    emit(state.save());
  }
}
