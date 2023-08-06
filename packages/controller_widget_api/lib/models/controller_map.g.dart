// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ControllerMap _$$_ControllerMapFromJson(Map<String, dynamic> json) =>
    _$_ControllerMap(
      path: json['path'] as String,
      uid: json['uid'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      nextLayerId: json['nextLayerId'] as int?,
      nextObjectId: json['nextObjectId'] as int?,
      properties: json['properties'] == null
          ? null
          : ControllerProperties.fromJson(
              json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ControllerMapToJson(_$_ControllerMap instance) =>
    <String, dynamic>{
      'path': instance.path,
      'uid': instance.uid,
      'width': instance.width,
      'height': instance.height,
      'nextLayerId': instance.nextLayerId,
      'nextObjectId': instance.nextObjectId,
      'properties': instance.properties,
    };
