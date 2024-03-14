part of '../../codde_widgets.dart';

mixin HasTiled on HasGameRef {
  TiledComponent get tiledComponent {
    final parents = ancestors().whereType<TiledComponent>();
    assert(parents.isNotEmpty, 'Widget should be mounted on TiledComponent');
    return parents.first;
  }

  Layer? getLayer(int id) {
    return tiledComponent.tileMap.map.layers
        .singleWhere((element) => element.id == id);
  }
}
