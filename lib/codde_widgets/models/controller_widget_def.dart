import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/templates/widget_component.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'controller_widget_def.freezed.dart';
// part 'controller_widget_def.g.dart';

@freezed
class ControllerWidgetDef with _$ControllerWidgetDef {
  const factory ControllerWidgetDef(
      {required ControllerClass class_, // toString <=> uid
      required String description,
      required String name,
      required List<ControllerApiAttribute> api,
      @Default(ControllerCommitFrequency.triggered)
      ControllerCommitFrequency commitFrequency,
      required int size,
      required WidgetPainter? Function(
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style})
          painter,
      required Component Function(
              {required int id,
              required ControllerClass class_,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size})
          player}) = _ControllerWidgetDef;

  // factory ControllerWidgetDef.fromJson(Map<String, Object?> json) =>
  //     _$ControllerWidgetDefFromJson(json);
}

enum ControllerCommitFrequency { triggered, periodic, pressed, stream }
