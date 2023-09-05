import 'package:codde_com/codde_com.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

class ControllerPropertiesException {}

class ControllerProperties extends CustomProperties {
  ControllerProperties(super.byName);

  XmlNode toXml() {
    Iterable<XmlElement> properties =
        map((prop) => XmlElement(XmlName('property'), [
              XmlAttribute(XmlName("name"), prop.name),
              XmlAttribute(XmlName("value"), prop.value.toString()),
              XmlAttribute(XmlName("type"), prop.type.name),
            ]));
    return XmlElement(XmlName('properties'), [], properties);
  }

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
}
