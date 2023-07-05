import 'package:codde_pi/core/widgets/models/simple_button/simple_button.dart';
import 'package:codde_pi/core/widgets/models/unknown/unknown_button.dart';
import 'package:codde_pi/core/widgets/templates/widget_editor.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:path/path.dart';

/* class Reflector extends Reflectable {
  const Reflector() : super(newInstanceCapability);
}

const reflector = Reflector();

Object createInstanceOf(dynamic class_, List positionalArguments,
    Map<Symbol, dynamic> namedArguments) {
  final Map<ControllerClass, Type> factories = <ControllerClass, Type>{
    ControllerClass.unknown: UnknownButtonPlayer,
    ControllerClass.simple_button: SimpleButtonPlayer,
  };

  ClassMirror createInstance =
      reflector.reflectType(factories[class_]!) as ClassMirror;
  return createInstance.newInstance("", positionalArguments,
      namedArguments); // Same as createInstance() but null safety
} */

var factories = <ControllerClass, dynamic Function()>{
  ControllerClass.simple_button: () => SimpleButtonPainter(),
  ControllerClass.unknown: () => UnknownButtonPainter(),
};

Future<Component> createPlayerOf(dynamic class_, id, position) async {
  final widgetSvg = await getWidgetSvg(class_);
  final widgetPressedSvg = await getWidgetSvg(class_, pressed: true);
  final Map<ControllerClass, Component> factories =
      <ControllerClass, Component>{
    ControllerClass.unknown: UnknownButtonPlayer(
        id: id,
        position: position,
        svg: widgetSvg,
        pressedSvg: widgetPressedSvg),
    ControllerClass.simple_button: SimpleButtonPlayer(
        id: id,
        position: position,
        svg: widgetSvg,
        size: Vector2.all(100.0),
        pressedSvg: widgetPressedSvg)
  };
  return factories[class_]!;
}

String getWidgetAsset(ControllerClass class_,
    {ControllerStyle style = ControllerStyle.classic, bool pressed = false}) {
  final widget = EnumToString.convertToString(class_);
  final controllerStyle = EnumToString.convertToString(style);
  final filename =
      "${widget}_$controllerStyle${(pressed ? '_pressed' : '')}.svg";
  return join("widgets", widget, controllerStyle, filename);
}

Future<Svg> getWidgetSvg(ControllerClass class_,
    {ControllerStyle style = ControllerStyle.classic, bool pressed = false}) {
  final path = getWidgetAsset(class_, style: style, pressed: pressed);
  return Svg.load(path);
}

class ControllerWidgetProvider {
  ControllerWidgetMode mode;
  ControllerWidgetProvider(this.mode);

  dynamic generateWidget(
      {required int id,
      required ControllerClass? class_,
      required int x,
      required int y}) {
    ControllerClass classed;
    if (class_ == null || !factories.containsKey(class_)) {
      classed = ControllerClass.unknown;
    } else {
      classed = class_;
    }
    switch (mode) {
      case ControllerWidgetMode.editor:
        // TODO: turn to spriteComponent
        return WidgetEditor(
            size: Vector2.all(100),
            id: id,
            position: Vector2(x.toDouble(), y.toDouble()),
            painter:
                factories[classed]!() /* createInstanceOf(mode, class_) */);
      default: // player
        /* return createInstanceOf(classed, [], {
          #id: id,
          #position: Vector2(x.toDouble(), y.toDouble())
        }); */
        return createPlayerOf(classed, id, Vector2(x.toDouble(), y.toDouble()));
    }
  }
}

enum ControllerWidgetMode { editor, player }
