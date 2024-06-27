import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/paint/pixel_button_painter.dart';
import 'package:codde_pi/components/add_widget/add_widget_dialog.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/theme.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path/path.dart';

import '../store/controller_editor_store.dart';
import 'saving_button.dart';

class ControllerEditorGame extends FlameGame {
  String path;
  late TiledComponent mapComponent;
  CoddeBackend backend;
  final ControllerWidgetMode mode = ControllerWidgetMode.editor;

  ControllerEditorGame(this.path, {CoddeBackend? backend})
      : backend = backend ?? getLocalBackend();

  final store = ControllerEditorStore();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    logger.i("LOADING");
    final dummyProtocol =
        FlameCoddeProtocol(protocol: Protocol.webSocket, address: '');
    String content = await backend.readSync(path);
    mapComponent = await CoddeTiledComponent.load(content, mode: mode);
    dummyProtocol.add(mapComponent);
    add(dummyProtocol);

    await loadSavingButton();
    // await loadSaveButton();
  }

  /* Future loadSaveButton() async {
      final sprite = Sprite.load()
      add(HudMarginComponent(
        anchor: Anchor.topRight, margin: const EdgeInsets.all(widgetGutter), children: SpriteComponent(sprite: )));

  } */
  Future<void> loadSavingButton() async {
    final sprite = await Sprite.load("icons/save.png");
    add(HudButtonComponent(
        anchor: Anchor.topRight,
        size: Vector2.all(50.0),
        margin: const EdgeInsets.only(right: widgetGutter, top: widgetGutter),
        onPressed: () async =>
            await ControllerMap(map: mapComponent.tileMap.map, path: path)
                .saveMap(),
        button: CustomPainterComponent(
          priority: 5,
          size: Vector2.all(56.0),
          painter: PixelButtonPainter(
              outlineWidth: cOutlineWidth,
              text: "SAVE",
              pixelSize: cPixelSize,
              fillColor: accent), // TODO: get OnSurface color

          /* children: [
            SpriteComponent(
              size: Vector2.all(60.0),
              sprite: sprite,
            )
          ], */
        ),
        buttonDown: CustomPainterComponent(
          priority: 5,
          size: Vector2.all(56.0),
          painter: PixelButtonPainter(
              pressed: true,
              outlineWidth: cOutlineWidth,
              text: "SAVE",
              pixelSize: cPixelSize,
              fillColor: accent), // TODO: get OnSurface color

          /* children: [
            SpriteComponent(
              size: Vector2.all(60.0),
              sprite: sprite,
            )
          ], */
        )));
  }

  Widget _addWidgetBuilder(
      BuildContext buildContext, ControllerEditorGame game) {
    return AddWidgetDialog(funSelect: (ControllerWidgetDef def) {
      final WidgetComponent widgetComponent = generateWidget(
          mode: mode,
          context: buildContext,
          id: getNextObjectId(),
          class_: EnumToString.fromString(
                  ControllerClass.values, def.class_.name) ??
              ControllerClass.error,
          properties: def.defaultProperties ?? CustomProperties.empty,
          x: 50,
          y: 50) as WidgetComponent;
      overlays.remove('AddWidget');
      mapComponent.add(widgetComponent);
      store.add(widgetComponent);
      logger.d('component added');
      resumeEngine();
    }, funCancel: () {
      overlays.remove('AddWidget');
      resumeEngine();
    });
  }

  int getNextObjectId() {
    final res = mapComponent.tileMap.map.nextObjectId ?? 1;
    mapComponent.tileMap.map.nextObjectId = res + 1;
    return res;
  }

  Widget _introducingBuilder(
      BuildContext buildContext, ControllerEditorGame game) {
    // TODO: set Protrait/Landscape
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(widgetGutter),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(widgetGutter / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const material.Text("Edit your controller here"),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        overlays.remove('Introducing');
                      },
                      child: const material.Text("OK")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetDetailBuilder(
      BuildContext buildContext, ControllerEditorGame game) {
    return Container();
  }

  Widget overlayBuilder(BuildContext context) {
    return /* Observer(
      builder: (context) => */
        DynamicFabScaffold(
      destination: DynamicBarPager.controllerEditor,
      fab: DynamicFab(
          iconData: Icons.add,
          action: () async {
            print('add widget');
            /* await showDialog(
                context: context,
                builder: (context) => AddWidgetDialog(
                    funSelect: (ControllerWidgetDef def) {
                      final WidgetComponent widgetComponent = generateWidget(
                          mode: mode,
                          context: context,
                          id: getNextObjectId(),
                          class_: EnumToString.fromString(
                                  ControllerClass.values, def.class_.name) ??
                              ControllerClass.error,
                          properties:
                              def.defaultProperties ?? CustomProperties.empty,
                          x: 50,
                          y: 50) as WidgetComponent;
                      Navigator.of(context).pop(widgetComponent);
                      // mapComponent.add(widgetComponent);
                      // store.add(widgetComponent);
                      // logger.d('component added');
                      // logger.d('list : ${mapComponent.children}');
                    },
                    funCancel: Navigator.of(context).pop)).then((value) {
              print('after dialog');
              mapComponent.add(value);
              // store.add(value);
              logger.d('component added');
              logger.d('list : ${mapComponent.children}');
            }); */
            overlays.add('AddWidget');
            pauseEngine();
          }),
      // key: scaffoldKey,
      body: SafeArea(
        child: GameWidget<ControllerEditorGame>(
          game: this,
          overlayBuilderMap: {
            'Introducing': _introducingBuilder,
            'AddWidget': _addWidgetBuilder,
            // 'WidgetDetail': _widgetDetailBuilder,
          },
          initialActiveOverlays: const [
            'Introducing'
          ], // TODO: check "don't show again" value
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          overlays.add('AddWidget');
          pauseEngine();
        },
        child: const Icon(Icons.add),
      ), */ // ),
    );
  }
}
