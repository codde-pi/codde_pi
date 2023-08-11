import 'package:codde_com/codde_com.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'controller_properties.freezed.dart';
part 'controller_properties.g.dart';

@freezed
class ControllerProperties with _$ControllerProperties {
  const ControllerProperties._();
  factory ControllerProperties({
    required int deviceId,
    String? executable,
  }) = _ControllerProperties;
  factory ControllerProperties.fromJson(Map<String, Object?> json) =>
      _$ControllerPropertiesFromJson(json);

  XmlNode toXml() {
    return XmlElement(XmlName('properties'), [], [
      XmlElement(XmlName('property'), [
        XmlAttribute(XmlName("name"), "deviceId"),
        XmlAttribute(XmlName("value"), deviceId.toString()),
      ]),
      if (executable != null)
        XmlElement(XmlName('property'), [
          XmlAttribute(XmlName("name"), "executable"),
          XmlAttribute(XmlName("value"), executable!),
        ]),
    ]);
  }

  @Assert("props.getValue('deviceId') != null",
      "fromFlame: [deviceId] is mandatory")
  factory ControllerProperties.fromFlame(CustomProperties props) {
    /* ControllerProperties.fromJson(
          Map.fromEntries(props.map<MapEntry<String, dynamic>>((e) {
        return MapEntry(e.name, e.value);
      }))); */
    final int? deviceId = int.tryParse(props.getValue('deviceId'));
    final String? executable = props.getValue('executable');
    if (deviceId == null) throw ControllerPropertiesException;
    return ControllerProperties(deviceId: deviceId, executable: executable);
  }
}

class ControllerPropertiesException {}
