// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerLayer _$ControllerLayerFromJson(Map<String, dynamic> json) =>
    ControllerLayer(
      id: json['id'] as int,
      size: ControllerSize.fromJson(json['size'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ControllerLayerToJson(ControllerLayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
      'data': instance.data,
      'name': instance.name,
    };
