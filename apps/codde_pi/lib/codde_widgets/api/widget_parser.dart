part of '../codde_widgets.dart';

Future<Component> createPlayerOf(BuildContext context, ControllerClass class_,
    id, position, style, text, ControllerProperties properties) async {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  assert(
      def != null, "No widget definition found"); // TODO: clean error raising
  return def!.component(
      class_: class_,
      id: id,
      position: position, // TODO: margin
      properties: properties,
      style: style,
      text: text);
}

Component createEditorOf(BuildContext context, ControllerClass class_, id,
    position, style, text, ControllerProperties properties) {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  final WidgetComponent component = def!.component(
      class_: class_,
      id: id,
      position: Vector2(0, 0),
      properties: properties,
      style: style,
      text: text);

  assert(def != null);
  return WidgetEditor(
      id: id,
      class_: class_,
      position: position, // TODO: margin
      size: component.size,
      sizeFactor: component.sizeFactor,
      // text: text,
      children: [
        WidgetDummy(position: Vector2(0, 0), children: [component])
      ]);
}

Component createDummyOf(BuildContext context, ControllerClass class_, id,
    position, style, text, ControllerProperties properties) {
  final ControllerWidgetDef? def = controllerWidgetDef[class_.name];
  final WidgetComponent component = def!.component(
      class_: class_,
      id: id,
      position: Vector2(0, 0),
      properties: properties,
      style: style,
      text: text);

  assert(def != null);
  return WidgetDummy(
      // size: component.size,
      position: position, // TODO: margin
      children: [component]);
}

dynamic generateWidget(
    {required BuildContext context,
    required int id,
    required ControllerClass class_,
    required int x,
    required int y,
    ControllerStyle style = ControllerStyle.material,
    String? text,
    ControllerWidgetMode? mode = ControllerWidgetMode.dummy,
    required CustomProperties properties}) {
  final ControllerProperties props = ControllerProperties(properties.byName);
  switch (mode) {
    case ControllerWidgetMode.editor:
      return createEditorOf(context, class_, id,
          Vector2(x.toDouble(), y.toDouble()), style, text, props);
    case ControllerWidgetMode.player: // player
      return createPlayerOf(
        context,
        class_,
        id,
        Vector2(x.toDouble(), y.toDouble()),
        style,
        text,
        props,
      );
    default:
      return createDummyOf(
        context,
        class_,
        id,
        Vector2(x.toDouble(), y.toDouble()),
        style,
        text,
        props,
      );
  }
}

enum ControllerWidgetMode { editor, player, dummy }
