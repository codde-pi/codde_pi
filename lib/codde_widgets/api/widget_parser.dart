import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/registry/simple_button/simple_button_painter.dart';
import 'package:codde_pi/codde_widgets/templates/widget_painter.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

const SCALE_FACTOR = 100.0;

WidgetPainter getPainter(
    BuildContext context, ControllerClass class_, ControllerStyle style) {
  final colorscheme = Theme.of(context).colorScheme;
  final Map<ControllerClass, WidgetPainter> factories = {
    ControllerClass.unknown:
        WidgetPainter(colorscheme: colorscheme, style: style),
    ControllerClass.simple_button:
        SimpleButtonPainter(colorscheme: colorscheme, style: style),
  };
  return factories[class_] ??
      WidgetPainter(colorscheme: colorscheme, style: style);
}

Future<Component> createPlayerOf(
    BuildContext context, ControllerClass class_, id, position, style) async {
  print(class_);
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  assert(def != null);
  final Map<ControllerClass, Component> factories =
      <ControllerClass, Component>{
    ControllerClass.unknown: UnknownButtonPlayer(
      class_: class_,
      id: id,
      position: position,
    ),
    ControllerClass.simple_button: SimpleButtonPlayer(
      class_: class_,
      id: id,
      position: position,
      painter: getPainter(context, class_, style),
      size: Vector2.all(def!.size * SCALE_FACTOR),
    ),
    ControllerClass.joystick: UnknownButtonPlayer(
      class_: class_,
      id: id,
      position: position,
    ),
  };
  return factories[class_]!;
}

Component createEditorOf(
    BuildContext context, ControllerClass class_, id, position, style) {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  print(class_);
  assert(def != null);
  return WidgetEditor(
      id: id,
      class_: class_,
      size: Vector2.all(def!.size * SCALE_FACTOR),
      position: position,
      painter: getPainter(context, class_, style));
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
      ControllerStyle style = ControllerStyle.material}) {
    switch (mode) {
      case ControllerWidgetMode.editor:
        return createEditorOf(
            context, class_, id, Vector2(x.toDouble(), y.toDouble()), style);
      default: // player
        return createPlayerOf(
            context, class_, id, Vector2(x.toDouble(), y.toDouble()), style);
    }
  }
}

enum ControllerWidgetMode { editor, player }

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
  // TODO: replace named material colors by current context colors (CONTEXT !)
  // TODO: derive a pressed SVG if `pressed`
  return Svg.load(path);
}
