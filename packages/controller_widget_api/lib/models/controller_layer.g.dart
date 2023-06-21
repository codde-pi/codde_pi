// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerLayer _$ControllerLayerFromJson(Map<String, dynamic> json) =>
    ControllerLayer(
      id: json['id'] as int,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ControllerLayerToJson(ControllerLayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'name': instance.name,
    };
