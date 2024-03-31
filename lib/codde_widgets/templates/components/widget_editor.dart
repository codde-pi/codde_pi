part of '../../codde_widgets.dart';

class WidgetEditor extends WidgetComponent
    with TapCallbacks, DragCallbacks, HasTiled {
  double sizeFactor;
  WidgetEditor({
    required super.id,
    required super.class_,
    super.text,
    super.position,
    super.margin,
    super.size,
    required this.sizeFactor,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  }) : super(properties: ControllerProperties.empty);

  ControllerWidgetMode mode = ControllerWidgetMode.editor;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    /* add(RectangleComponent(
        size: size,
        scale: scale,
        position: Vector2(0, 0),
        paint: Paint()..color = Colors.red)); // DEBUG */
  }

  @override
  void onTapUp(TapUpEvent event) async {
    // navigation to bottom sheet
    final props = await showModalBottomSheet(
        context: gameRef.buildContext!,
        builder: (context) =>
            WidgetDetailsSheet(widgetLayer: getLayer(id)!, class_: class_));
    if (props != null) {
      getLayer(id)!.properties = props;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) => position += event.localDelta;

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    getLayer(id)!
      ..y = position.y.toInt()
      ..x = position.x.toInt();
    // TODO: use offset with margin
  }

  @override
  void onMount() {
    super.onMount();
    // FIXME: depends if it already exists or not
    if (tiledComponent.tileMap.map.layers
        .where((element) => element.id == id)
        .isEmpty) {
      tiledComponent.tileMap.map.layers.add(ObjectGroup(
          id: id,
          name: nickyName,
          x: position.x.toInt(),
          y: position.y.toInt(),
          // TODO: use offset with margin
          class_: class_.name,
          objects: [])); // TODO: widgets as TiledLayer instead
    }
  }

  @override
  void onRemove() {
    // TODO: check onRemove is called after saving map
    TiledComponent? tiledComponent =
        ancestors().whereType<TiledComponent>().firstOrNull;
    if (tiledComponent != null) {
      tiledComponent.tileMap.map.layers
          .removeWhere((element) => element.id == id);
    }
    super.onRemove();
  }
}
