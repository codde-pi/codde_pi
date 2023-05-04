// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerMap _$ControllerMapFromJson(Map<String, dynamic> json) =>
    ControllerMap(
      path: json['path'] as String,
      layer: json['layer'] == null
          ? null
          : ControllerLayer.fromJson(json['layer'] as Map<String, dynamic>),
      uid: json['uid'] as String?,
      size: json['size'] == null
          ? null
          : ControllerSize.fromJson(json['size'] as Map<String, dynamic>),
      backgrounds: (json['backgrounds'] as List<dynamic>?)
          ?.map((e) => ControllerBackground.fromJson(e as Map<String, dynamic>))
          .toList(),
      widgets: (json['widgets'] as List<dynamic>?)
          ?.map((e) => ControllerWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextLayerId: json['nextLayerId'] as int?,
      nextObjectId: json['nextObjectId'] as int?,
    );

Map<String, dynamic> _$ControllerMapToJson(ControllerMap instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'size': instance.size,
      'path': instance.path,
      'layer': instance.layer,
      'backgrounds': instance.backgrounds,
      'widgets': instance.widgets,
      'nextLayerId': instance.nextLayerId,
      'nextObjectId': instance.nextObjectId,
    };
