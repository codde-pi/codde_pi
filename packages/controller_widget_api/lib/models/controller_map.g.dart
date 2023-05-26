// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerMap _$ControllerMapFromJson(Map<String, dynamic> json) =>
    ControllerMap(
      path: json['path'] as String,
      uid: json['uid'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      backgrounds: (json['backgrounds'] as List<dynamic>?)
          ?.map((e) => ControllerBackground.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextLayerId: json['nextLayerId'] as int?,
      nextObjectId: json['nextObjectId'] as int?,
      properties: json['properties'] == null
          ? null
          : ControllerProperties.fromJson(
              json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ControllerMapToJson(ControllerMap instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'path': instance.path,
      'backgrounds': instance.backgrounds,
      'nextLayerId': instance.nextLayerId,
      'nextObjectId': instance.nextObjectId,
      'width': instance.width,
      'height': instance.height,
      'properties': instance.properties,
    };
