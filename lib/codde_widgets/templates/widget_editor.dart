import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/templates/widget_component.dart';
import 'package:codde_pi/components/codde_controller/bloc/edit_controller_bloc.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';

class WidgetEditor extends WidgetComponent
    with
        TapCallbacks,
        DragCallbacks,
        FlameBlocListenable<EditControllerBloc, EditControllerState>,
        FlameBlocReader<EditControllerBloc, EditControllerState> {
  WidgetEditor({
    required super.id,
    required super.class_,
    super.painter,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  bool _isDragged = false;
  ControllerWidgetProvider widgetProvider =
      ControllerWidgetProvider(ControllerWidgetMode.editor);

  @override
  void onTapUp(TapUpEvent event) {
    bloc.add(ControllerWidgetClicked(id));
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    // bloc.add(ControllerWidgetLongTaped(id));
    print('hello');
  }

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) => _isDragged = true;

  @override
  void onDragUpdate(DragUpdateEvent event) => position += event.delta;

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    bloc.add(ControllerWidgetMoved(id, position.x.toInt(), position.y.toInt()));
  }

  //  @override
  // @mustCallSuper
  // void render(Canvas canvas) {
  //   painter.render();
  // }

  @override
  bool listenWhen(
      EditControllerState previousState, EditControllerState newState) {
    // return true/false to determine whether or not
    // to call listener with state
    return newState.widgets[id] != previousState.widgets[id];
  }

  @override
  void onNewState(EditControllerState state) {
    super.onNewState(state);
    final widget = state.widgets[id];
    position = Vector2(widget!.x.toDouble(), widget.y.toDouble());
  }
}