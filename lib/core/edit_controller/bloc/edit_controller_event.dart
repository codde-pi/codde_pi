part of 'edit_controller_bloc.dart';

abstract class EditControllerEvent extends Equatable {
  const EditControllerEvent();

  @override
  List<Object> get props => [];
}

class EditControllerSubscriptionRequested extends EditControllerEvent {
  const EditControllerSubscriptionRequested();
}

class ControllerWidgetRemoved extends EditControllerEvent {
  const ControllerWidgetRemoved(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ControllerWidgetAdded extends EditControllerEvent {
  const ControllerWidgetAdded(this.widget);

  final ControllerWidget widget;

  @override
  List<Object> get props => [widget];
}

class ControllerWidgetClicked extends EditControllerEvent {
  const ControllerWidgetClicked(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ControllerWidgetLongTaped extends EditControllerEvent {
  const ControllerWidgetLongTaped(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ControllerWidgetSelectedCanceled extends EditControllerEvent {
  const ControllerWidgetSelectedCanceled(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ControllerWidgetCanceled extends EditControllerEvent {
  const ControllerWidgetCanceled();
}

class ControllerWidgetMoved extends EditControllerEvent {
  const ControllerWidgetMoved(this.id, this.position);

  final int id;
  final Offset position;

  @override
  List<Object> get props => [id, position];
}
