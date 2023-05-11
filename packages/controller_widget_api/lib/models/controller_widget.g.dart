// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerWidget _$ControllerWidgetFromJson(Map<String, dynamic> json) =>
    ControllerWidget(
      id: json['id'] as int,
      x: json['x'] as int?,
      y: json['y'] as int?,
      name: json['name'] as String?,
      class_: $enumDecodeNullable(_$ControllerClassEnumMap, json['class_']),
      background: json['background'] == null
          ? null
          : ControllerBackground.fromJson(
              json['background'] as Map<String, dynamic>),
      widgets: (json['widgets'] as List<dynamic>?)
          ?.map((e) => ControllerWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ControllerWidgetToJson(ControllerWidget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
      'class_': _$ControllerClassEnumMap[instance.class_],
      'name': instance.name,
      'background': instance.background,
      'widgets': instance.widgets,
    };

const _$ControllerClassEnumMap = {
  ControllerClass.unknown: 'unknown',
  ControllerClass.simple_button: 'simple_button',
  ControllerClass.joystick: 'joystick',
};
