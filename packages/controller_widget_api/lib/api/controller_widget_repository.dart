part of 'controller_widget_api.dart';

class ControllerWidgetRepository {
  const ControllerWidgetRepository(this.controllerWidgetApi);

  final ControllerWidgetApi controllerWidgetApi;

  Stream<List<ControllerWidget>> getWidgets() {
    return controllerWidgetApi.getWidgets();
  }

  Future<Object>? deleteMap(ControllerMap map) {
    return controllerWidgetApi.deleteMap(map);
  }

  ControllerWidget addWidget(ControllerWidget widget) {
    return controllerWidgetApi.addWidget(widget);
  }

  List<ControllerWidget> addAll(List<ControllerWidget> widgets) {
    return controllerWidgetApi.addAll(widgets);
  }

  List<ControllerWidget> parseLayers(List<Layer> layers) {
    return controllerWidgetApi.parseLayers(layers);
  }

  Future<File> saveMap(ControllerMap map) {
    return controllerWidgetApi.saveMap(map);
  }

  ControllerWidget modifyWidget(ControllerWidget widget) {
    return controllerWidgetApi.modifyWidget(widget);
  }
}
