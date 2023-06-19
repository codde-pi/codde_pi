// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_widget_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ControllerWidgetId _$$_ControllerWidgetIdFromJson(
        Map<String, dynamic> json) =>
    _$_ControllerWidgetId(
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
    );

Map<String, dynamic> _$$_ControllerWidgetIdToJson(
        _$_ControllerWidgetId instance) =>
    <String, dynamic>{
      'class_': _$ControllerClassEnumMap[instance.class_]!,
      'description': instance.description,
      'name': instance.name,
      'api': instance.api,
      'commitFrequency':
          _$ControllerCommitFrequencyEnumMap[instance.commitFrequency]!,
    };

const _$ControllerClassEnumMap = {
  ControllerClass.unknown: 'unknown',
  ControllerClass.simple_button: 'simple_button',
  ControllerClass.joystick: 'joystick',
};

const _$ControllerCommitFrequencyEnumMap = {
  ControllerCommitFrequency.triggered: 'triggered',
  ControllerCommitFrequency.periodic: 'periodic',
};

_$_ControllerApiAttribute _$$_ControllerApiAttributeFromJson(
        Map<String, dynamic> json) =>
    _$_ControllerApiAttribute(
      key: json['key'] as String?,
      valueType: json['valueType'] as String,
      defaultValue: json['defaultValue'],
    );

Map<String, dynamic> _$$_ControllerApiAttributeToJson(
        _$_ControllerApiAttribute instance) =>
    <String, dynamic>{
      'key': instance.key,
      'valueType': instance.valueType,
      'defaultValue': instance.defaultValue,
    };
