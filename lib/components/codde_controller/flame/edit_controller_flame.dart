import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_controller/utils/hatch_background.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class EditControllerFlame extends FlameGame {
  EditControllerFlame(this.edit_controller_bloc);

  EditControllerBloc edit_controller_bloc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // camera.viewport = FixedResolutionViewport(Vector2(16 * 28, 16 * 14));

    add(FlameBlocProvider<EditControllerBloc, EditControllerState>(
        create: () => edit_controller_bloc,
        children: [EditControllerFlameView()]));
  }
}

class WidgetReader extends Component
    with FlameBlocReader<EditControllerBloc, EditControllerState> {}

class EditControllerFlameView extends PositionComponent with HasGameRef {
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
  late TiledComponent mapComponent;
  final reader = WidgetReader();
  final backend = GetIt.I.get<CoddeBackend>();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(reader);

    String content = '';
    await backend
        .read(reader.bloc.state.map!.path)
        .then((value) => value.forEach((element) {
              content += element;
              content += "\n";
            }));
    mapComponent = await load(content, Vector2.all(100));
    add(mapComponent);
  }

  @override
  void onMount() {
    if (gameRef.buildContext != null) {
      if (!reader.bloc.state.map!.xmlRead()) {
        reader.bloc.add(ControllerMapDefined(reader.bloc.state.map!.copyWith(
            nextLayerId: mapComponent.tileMap.map.nextLayerId,
            nextObjectId: mapComponent.tileMap.map.nextObjectId)));
      }
      if (reader.bloc.state.widgets.isEmpty) {
        List<Layer> layers = mapComponent.tileMap.map.layers;
        reader.bloc.add(ControllerLayerParsed(layers));
      } else {
        reader.bloc.state.widgets.forEach((key, value) {
          add(provider.generateWidget(
              context: gameRef.buildContext!,
              id: value.id,
              class_: value.class_ ?? ControllerClass.unknown,
              x: value.x,
              y: value.y) as Component);
        });
      }
      mapComponent.add(CustomPainterComponent(
          size: Vector2.all(1),
          painter: HatchBackground(
              colorscheme: Theme.of(gameRef.buildContext!).colorScheme)));
    }
  }

  /* @override
  void render(Canvas canvas) {
    if (gameRef.buildContext != null) {
      canvas.drawColor(Theme.of(gameRef.buildContext!).colorScheme.background,
          BlendMode.color);
    }
  } */

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
