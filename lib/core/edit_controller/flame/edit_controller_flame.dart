import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';

class EditControllerFlame extends FlameGame {
  EditControllerFlame(this.edit_controller_bloc);

  EditControllerBloc edit_controller_bloc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.zoom = 0;
    // camera.viewport = FixedResolutionViewport(Vector2(16 * 28, 16 * 14));

    add(FlameBlocProvider<EditControllerBloc, EditControllerState>(
        create: () => edit_controller_bloc,
        children: [EditControllerFlameView()]));
  }
}

class WidgetReader extends Component
    with FlameBlocReader<EditControllerBloc, EditControllerState> {}

class EditControllerFlameView extends PositionComponent {
  EditControllerFlameView({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor = Anchor.topLeft,
    super.children,
    super.priority,
  });
  ControllerWidgetProvider provider =
      ControllerWidgetProvider(ControllerWidgetMode.editor);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final reader = WidgetReader();
    add(reader);

    late TiledComponent mapComponent;
    mapComponent =
        await TiledComponent.load(reader.bloc.state.map.path, Vector2.all(16));
    add(mapComponent);

    if (reader.bloc.state.widgets.isEmpty) {
      List<Layer> layers = mapComponent.tileMap.map.layers;
      reader.bloc.add(ControllerLayerParsed(layers));
    } else {
      reader.bloc.state.widgets.forEach((key, value) {
        add(provider.generateWidget(
            id: value.id, class_: value.class_, position: value.position));
      });
    }
  }

/*   @override
  bool listenWhen(
      EditControllerState previousState, EditControllerState newState) {
    // return true/false to determine whether or not
    // to call listener with state
    return newState.widgets != previousState.widgets;
  }

  @override
  void onNewState(EditControllerState state) {
    super.onNewState(state);
    // do stuff here based on state
    state.widgets.forEach((key, value) {
      // add(provider.generateWidget(
      //     id: key, class_: value.class_, position: value.position));
      if (value.class_ == ControllerClass.simple_button) {
        add(WidgetEditor(
            size: Vector2.all(100),
            id: key,
            painter:
                SimpleButtonPainter() /* createInstanceOf(mode, class_) */));
      }
    });
  } */
}
