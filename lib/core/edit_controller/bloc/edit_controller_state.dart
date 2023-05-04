part of 'edit_controller_bloc.dart';

class EditControllerState extends Equatable {
  late ControllerMap map = ControllerMap(path: path);
  final Map<int, ControllerWidget> widgets;
  final int? showDetails;
  final int? movable;
  final ControllerWidget? lastDeletedWidget;
  final ControllerStatus status;
  final String path;

  EditControllerState(
      {required this.path,
      ControllerMap? map,
      this.widgets = const <int, ControllerWidget>{},
      this.showDetails,
      this.movable,
      this.lastDeletedWidget,
      this.status = ControllerStatus.loading});

  EditControllerState copyWith({
    String? path,
    ControllerMap? map,
    Map<int, ControllerWidget>? widgets,
    int? showDetails,
    int? movable,
    ControllerWidget? lastDeletedWidget,
    ControllerStatus? status,
  }) {
    return EditControllerState(
        path: path ?? this.path,
        map: map ?? this.map,
        widgets: widgets ?? this.widgets,
        showDetails: showDetails ?? this.showDetails,
        movable: movable ?? this.movable,
        lastDeletedWidget: lastDeletedWidget ?? this.lastDeletedWidget,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [map, widgets, showDetails, movable, lastDeletedWidget, status];

  /* EditControllerState removeWidget(int id) {
    var newMap = Map.of(widgets);
    final removedWidget = newMap.remove(id);
    return copyWith(lastDeletedWidget: removedWidget, widgets: newMap);
  } */

 /*  EditControllerState addWidget(ControllerWidget widget) {
    final newMap = {...widgets};
    //Map<int, ControllerWidget>.of(widgets);
    newMap[widget.id] = widget;
    final isLayer = widget.background != null;
    return copyWith(
      widgets: newMap,
      /* map: map.copyWith(
            nextLayerId: isLayer ? widget.id + 1 : null,
            nextObjectId: !isLayer ? widget.id + 1 : null) */
    );
  } */
}
