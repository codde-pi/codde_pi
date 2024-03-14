part of '../../codde_widgets.dart';

class WidgetEditor extends WidgetComponent
    with TapCallbacks, DragCallbacks, HasTiled {
  WidgetEditor({
    required super.id,
    required super.class_,
    super.text,
    super.position,
    super.margin,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  }) : super(properties: ControllerProperties.empty);

  ControllerWidgetMode mode = ControllerWidgetMode.editor;

  @override
  FutureOr<void> onLoad() {
    // HACK: DO NOT use [WidgetComponent.onLoad]!
    // size assignment issue
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
      ..offsetY = position.y
      ..offsetX = position.x;
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
          offsetX: position.x,
          offsetY: position.y,
          class_: class_.toString(),
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

  @override
  int get defaultSize => 1;
}
