part of '../codde_widgets.dart';

class ControllerPropertiesException {}

class ControllerProperties extends CustomProperties {
  static const empty = ControllerProperties({});
  const ControllerProperties(super.byName);

  void update(Map<String, Property<Object>> map) {
    map.forEach((key, value) =>
        byName.update(key, (v) => value, ifAbsent: () => value));
  }

  void updateItem(
          String key, Property<Object> Function(Property<Object>) value) =>
      byName.update(key, value);
  ControllerProperties copyWith(Map<String, Property<Object>> map) {
    update(map);
    return ControllerProperties(byName);
  }

  Map toJson() {
    return byName.map((key, value) => MapEntry(key, {
          "name": value.name,
          "type": value.type.toString(),
          "value": value.value.toString()
        }));
  }

  factory ControllerProperties.fromJson(
      Map<String, Map<String, dynamic>> value) {
    Map<String, Property<Object>> map = value.map((key, value) => MapEntry(
        key,
        Property(
            name: value["name"], type: value["type"], value: value["value"])));
    return ControllerProperties(map);
  }

  factory ControllerProperties.fromDevice(int deviceId) =>
      ControllerProperties({
        'deviceId':
            Property(name: "deviceId", type: PropertyType.int, value: deviceId)
      });
  factory ControllerProperties.defaultController(Map<String, Property>? props) {
    Iterable<MapEntry<String, Property<Object>>> map =
        controllerSettings.map((Property<Object> e) {
      return MapEntry(
          e.name,
          e
            ..value =
                props != null ? (props[e.name]?.value ?? e.value) : e.value);
    });
    return ControllerProperties(Map<String, Property<Object>>.fromEntries(map));
  }

  bool? get disabled => getValue<bool>("disabled");

  int? get size => getValue<int>("size");

  bool? get landscape => getValue<bool>("landscape");
}

final List<Property<Object>> controllerSettings = [
  Property(name: "landscape", type: PropertyType.bool, value: false),
];
