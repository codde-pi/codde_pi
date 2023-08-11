import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';

class CoddeTiledComponent extends TiledComponent {
  CoddeTiledComponent(super.tileMap, {super.priority});
  ControllerWidgetProvider provider =
      ControllerWidgetProvider(ControllerWidgetMode.player);
  @override
  void onMount() async {
    super.onMount();
    // Placed here to use gameRef
    for (var value in tileMap.map.layers) {
      if (game.buildContext != null) {
        add(await provider.generateWidget(
            context: gameRef.buildContext!,
            id: value.id!,
            class_: EnumToString.fromString(
                    ControllerClass.values, value.class_ ?? '') ??
                ControllerClass.unknown,
            x: value.x,
            y: value.y));
      }
    }
  }
}
