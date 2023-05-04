// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerLayer _$ControllerLayerFromJson(Map<String, dynamic> json) =>
    ControllerLayer(
      id: json['id'] as String?,
      size: json['size'] == null
          ? null
          : ControllerSize.fromJson(json['size'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)?.map((e) => e as int).toList(),
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ControllerLayerToJson(ControllerLayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
      'y': instance.y,
      'x': instance.x,
      'data': instance.data,
    };
