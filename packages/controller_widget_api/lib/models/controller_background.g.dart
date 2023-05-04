// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerBackground _$ControllerBackgroundFromJson(
        Map<String, dynamic> json) =>
    ControllerBackground(
      name: json['name'] as String,
      size: ControllerSize.fromJson(json['size'] as Map<String, dynamic>),
      source: json['source'] as String,
    );

Map<String, dynamic> _$ControllerBackgroundToJson(
        ControllerBackground instance) =>
    <String, dynamic>{
      'size': instance.size,
      'name': instance.name,
      'source': instance.source,
    };
