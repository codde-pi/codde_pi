part of 'edit_controller_bloc.dart';

class EditControllerState extends Equatable {
  final ControllerMap? map;
  final Map<int, ControllerWidget> widgets;
  final int? showDetails;
  final int? movable;
  final ControllerWidget? lastDeletedWidget;
  final ControllerStatus status;
  final bool saved;

  const EditControllerState(
      {this.map,
      this.widgets = const <int, ControllerWidget>{},
      this.showDetails,
      this.movable,
      this.lastDeletedWidget,
      this.saved = true,
      this.status = ControllerStatus.loading});

  EditControllerState copyWith({
    ControllerMap? map,
    Map<int, ControllerWidget>? widgets,
    int? showDetails,
    int? movable,
    ControllerWidget? lastDeletedWidget,
    bool? saved,
    ControllerStatus? status,
  }) {
    return EditControllerState(
        map: map ?? this.map,
        widgets: widgets ?? this.widgets,
        showDetails: showDetails ?? this.showDetails,
        movable: movable ?? this.movable,
        lastDeletedWidget: lastDeletedWidget ?? this.lastDeletedWidget,
        saved: saved ?? this.saved,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [map, widgets, showDetails, movable, lastDeletedWidget, saved, status];

  EditControllerState edit() {
    return copyWith(saved: false);
  }

  EditControllerState save() {
    return copyWith(saved: true);
  }
}
