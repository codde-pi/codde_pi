part of 'controller_widget_api.dart';

class ControllerWidgetRepository {
  const ControllerWidgetRepository(this.controllerWidgetApi);

  final ControllerWidgetApi controllerWidgetApi;

  Stream<Map<int, ControllerWidget>> streamWidgets() {
    return controllerWidgetApi.streamWidgets();
  }

  Stream<ControllerMap> streamMap() {
    return controllerWidgetApi.streamMap();
  }

  Map<int, ControllerWidget> getWidgetsOnce() {
    return controllerWidgetApi.getWidgetsOnce();
  }

  Future<Object>? deleteMap(ControllerMap map) {
    return controllerWidgetApi.deleteMap(map);
  }

  void updateMap(ControllerMap map) {
    return controllerWidgetApi.updateMap(map);
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

  Future<FileEntity> saveMap() {
    return controllerWidgetApi.saveMap();
  }

  Future<FileEntity> createMap() {
    return controllerWidgetApi.createMap();
  }

  ControllerWidget modifyWidget(ControllerWidget widget) {
    return controllerWidgetApi.modifyWidget(widget);
  }

  ControllerWidget? removeWidget(int id) {
    return controllerWidgetApi.removeWidget(id);
  }

  String? editProperties(ControllerProperties props) {
    return controllerWidgetApi.editProperties(props);
  }

  Future<FileEntity> saveProperties() {
    return controllerWidgetApi.saveProperties();
  }
}
