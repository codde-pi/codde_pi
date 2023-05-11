// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerProperties _$ControllerPropertiesFromJson(
        Map<String, dynamic> json) =>
    ControllerProperties(
      protocol: $enumDecode(_$CoddeProtocolEnumMap, json['protocol']),
      deviceId: json['deviceId'] as String?,
      executable: json['executable'] as String?,
    );

Map<String, dynamic> _$ControllerPropertiesToJson(
        ControllerProperties instance) =>
    <String, dynamic>{
      'protocol': _$CoddeProtocolEnumMap[instance.protocol]!,
      'deviceId': instance.deviceId,
      'executable': instance.executable,
    };

const _$CoddeProtocolEnumMap = {
  CoddeProtocol.socket: 'socket',
  CoddeProtocol.socketio: 'socketio',
  CoddeProtocol.usb: 'usb',
  CoddeProtocol.bluetooth: 'bluetooth',
  CoddeProtocol.http: 'http',
};
