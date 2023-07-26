// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_widget_def.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ControllerWidgetDef _$$_ControllerWidgetDefFromJson(
        Map<String, dynamic> json) =>
    _$_ControllerWidgetDef(
      class_: $enumDecode(_$ControllerClassEnumMap, json['class_']),
      description: json['description'] as String,
      name: json['name'] as String,
      api: (json['api'] as List<dynamic>)
          .map(
              (e) => ControllerApiAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      commitFrequency: $enumDecodeNullable(
              _$ControllerCommitFrequencyEnumMap, json['commitFrequency']) ??
          ControllerCommitFrequency.triggered,
      size: json['size'] as int,
    );

Map<String, dynamic> _$$_ControllerWidgetDefToJson(
        _$_ControllerWidgetDef instance) =>
    <String, dynamic>{
      'class_': _$ControllerClassEnumMap[instance.class_]!,
      'description': instance.description,
      'name': instance.name,
      'api': instance.api,
      'commitFrequency':
          _$ControllerCommitFrequencyEnumMap[instance.commitFrequency]!,
      'size': instance.size,
    };

const _$ControllerClassEnumMap = {
  ControllerClass.unknown: 'unknown',
  ControllerClass.simple_button: 'simple_button',
  ControllerClass.joystick: 'joystick',
};

const _$ControllerCommitFrequencyEnumMap = {
  ControllerCommitFrequency.triggered: 'triggered',
  ControllerCommitFrequency.periodic: 'periodic',
  ControllerCommitFrequency.pressed: 'pressed',
};
