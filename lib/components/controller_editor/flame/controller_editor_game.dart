import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/add_widget/add_widget_dialog.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/theme.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:get_it/get_it.dart';

class ControllerEditorGame extends FlameGame {
  String path;
  late TiledComponent mapComponent;
  final backend = GetIt.I.get<CoddeBackend>();
  final ControllerWidgetMode mode = ControllerWidgetMode.editor;

  ControllerEditorGame(this.path);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final dummyProtocol =
        FlameCoddeProtocol(protocol: Protocol.webSocket, address: '');
    String content = await backend.readSync(path);
    mapComponent = await CoddeTiledComponent.load(content, mode: mode);
    dummyProtocol.add(mapComponent);
    add(dummyProtocol);
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
    return Center(
      child: Padding(
        padding: EdgeInsets.all(widgetGutter),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(widgetGutter / 2),
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
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
          leadingWidth: 72,
          leading: TextButton(
            child: const material.Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          title: material.Text(path.split('/').last),
          actions: [
            IconButton(
                onPressed: () async {
                  await ControllerMap(map: mapComponent.tileMap.map, path: path)
                      .saveMap();
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.primary,
                )),
            // TODO: outline
            /* IconButton(
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                icon: const Icon(Icons.menu)), */
          ]),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          overlays.add('AddWidget');
          pauseEngine();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
