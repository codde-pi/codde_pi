import 'package:codde_pi/core/widgets/models/simple_button/simple_button.dart';
import 'package:codde_pi/core/widgets/models/unknown_button/unknown_button.dart';
import 'package:codde_pi/core/widgets/templates/widget_editor.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';

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
  ControllerClass.simple_button: () => new SimpleButtonPainter(),
  ControllerClass.unknown: () => new UnknownButtonPainter(),
};

Object createPlayerOf(dynamic class_, id, position, painter) {
  final Map<ControllerClass, Function> factories = <ControllerClass, Function>{
    ControllerClass.unknown: () =>
        UnknownButtonPlayer(id: id, position: position, painter: painter),
    ControllerClass.simple_button: () {
      print('hello');
      return SimpleButtonPlayer(
          id: id,
          position: position,
          painter: painter,
          size: Vector2.all(100.0));
    },
  };
  return factories[class_]!;
}

class ControllerWidgetProvider {
  ControllerWidgetMode mode;
  ControllerWidgetProvider(this.mode);

  dynamic generateWidget(
      {required int id,
      required ControllerClass? class_,
      required int x,
      required int y}) {
    var classed;
    if (class_ == null || !factories.containsKey(class_)) {
      classed = ControllerClass.unknown;
    } else {
      classed = class_;
    }
    switch (mode) {
      case ControllerWidgetMode.editor:
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
        return createPlayerOf(classed, id, Vector2(x.toDouble(), y.toDouble()),
            factories[classed]!());
    }
  }
}

enum ControllerWidgetMode { editor, player }
