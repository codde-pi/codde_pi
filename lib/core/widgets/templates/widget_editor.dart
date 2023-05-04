import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:controller_widget_api/models/controller_position.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';

class WidgetEditor extends CustomPainterComponent
    with
        HasGameRef,
        TapCallbacks,
        DragCallbacks,
        FlameBlocListenable<EditControllerBloc, EditControllerState>,
        FlameBlocReader<EditControllerBloc, EditControllerState> {
  WidgetEditor({
    required this.id,
    super.painter,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor = Anchor.topLeft,
    super.children,
    super.priority,
  });
  int id;
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
    bloc.add(ControllerWidgetMoved(
        id, ControllerPosition(position.x.toInt(), position.y.toInt())));
  }

  /*  @override
  @mustCallSuper
  void render(Canvas canvas) {
    if (_isDragged) canvas.drawRect(size.toRect(), Paint()..color = Colors.red);
  } */

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
    // do stuff here based on state
    final widget = state.widgets[id];
    position =
        Vector2(widget!.position.x.toDouble(), widget.position.x.toDouble());
  }
}
