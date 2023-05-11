import 'dart:io';

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

    final content = await File(reader.bloc.state.map!.path).readAsString();
    late TiledComponent mapComponent;
    mapComponent = await load(content, Vector2.all(16));
    add(mapComponent);

    if (reader.bloc.state.widgets.isEmpty) {
      List<Layer> layers = mapComponent.tileMap.map.layers;
      reader.bloc.add(ControllerLayerParsed(layers));
    } else {
      reader.bloc.state.widgets.forEach((key, value) {
        add(provider.generateWidget(
            id: value.id, class_: value.class_, x: value.x, y: value.y));
      });
    }
  }

  static Future<TiledComponent> load(
    String fileContent,
    Vector2 destTileSize, {
    int? priority,
    bool? ignoreFlip,
  }) async {
    return TiledComponent(
      await RenderableTiledMap.fromString(
        fileContent,
        destTileSize,
        ignoreFlip: ignoreFlip,
      ),
      priority: priority,
    );
  }
}
