import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/registry/simple_button/simple_button_painter.dart';
import 'package:codde_pi/codde_widgets/templates/widget_component.dart';
import 'package:codde_pi/codde_widgets/templates/widget_dummy.dart';
import 'package:codde_pi/codde_widgets/templates/widget_painter.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

const SCALE_FACTOR = 100.0;

Future<Component> createPlayerOf(BuildContext context, ControllerClass class_,
    id, position, style, ControllerProperties? properties, text) async {
  print(class_);
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  assert(def != null);
  return def!.player(
      class_: class_,
      id: id,
      painter:
          def.painter(colorscheme: Theme.of(context).colorScheme, style: style),
      position: position,
      size: Vector2.all(def.size * SCALE_FACTOR),
      properties: properties,
      text: text);
}

Component createEditorOf(
    BuildContext context, ControllerClass class_, id, position, style, text) {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  print(class_);
  assert(def != null);
  return WidgetEditor(
      id: id,
      class_: class_,
      size: Vector2.all(def!.size * SCALE_FACTOR),
      position: position,
      text: text,
      painter: def.painter(
          colorscheme: Theme.of(context).colorScheme, style: style));
}

Component createDummyOf(
    BuildContext context, ControllerClass class_, id, position, style, text) {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  print(class_);
  assert(def != null);
  return WidgetDummy(
      id: id,
      class_: class_,
      size: Vector2.all(def!.size * SCALE_FACTOR),
      position: position,
      text: text,
      painter: def.painter(
          colorscheme: Theme.of(context).colorScheme, style: style));
}

class ControllerWidgetProvider {
  ControllerWidgetMode mode;
  ControllerWidgetProvider(this.mode);

  dynamic generateWidget(
      {required BuildContext context,
      required int id,
      required ControllerClass class_,
      required int x,
      required int y,
      ControllerStyle style = ControllerStyle.material,
      String? text,
      ControllerProperties? properties}) {
    switch (mode) {
      case ControllerWidgetMode.editor:
        return createEditorOf(context, class_, id,
            Vector2(x.toDouble(), y.toDouble()), style, text);
      case ControllerWidgetMode.player: // player
        return createPlayerOf(context, class_, id,
            Vector2(x.toDouble(), y.toDouble()), style, properties, text);
      default:
        return createDummyOf(context, class_, id,
            Vector2(x.toDouble(), y.toDouble()), style, text);
    }
  }
}

enum ControllerWidgetMode { editor, player, overview }

@Deprecated('Use `CustomPainter` instead')
String getWidgetAsset(ControllerClass class_,
    {ControllerStyle style = ControllerStyle.material, bool pressed = false}) {
  final widget = EnumToString.convertToString(class_);
  final controllerStyle = EnumToString.convertToString(style);
  final filename =
      "${widget}_$controllerStyle${(pressed ? '_pressed' : '')}.svg";
  return join("widgets", widget, controllerStyle, filename);
}

@Deprecated('Use `CustomPainter` instead')
Future<Svg> getWidgetSvg(ControllerClass class_,
    {ControllerStyle style = ControllerStyle.material,
    bool pressed = false}) async {
  final path = getWidgetAsset(class_, style: style, pressed: pressed);
  return Svg.load(path);
}
