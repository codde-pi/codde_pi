import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame/components.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'controller_widget_def.freezed.dart';
// part 'controller_widget_def.g.dart';

@freezed
class ControllerWidgetDef with _$ControllerWidgetDef {
  const factory ControllerWidgetDef(
      {required ControllerClass class_, // toString <=> uid
      required String description,
      required WidgetRegistry? command,
      ResultRegistry? response,
      @Default(ControllerCommitFrequency.triggered)
      ControllerCommitFrequency commitFrequency,
      ControllerProperties? defaultProperties,
      required WidgetComponent Function(
              {required int id,
              required ControllerClass class_,
              required ControllerProperties properties,
              Vector2? position,
              Vector2? size,
              String? text,
              required ControllerStyle style})
          component}) = _ControllerWidgetDef;

  // factory ControllerWidgetDef.fromJson(Map<String, Object?> json) =>
  //     _$ControllerWidgetDefFromJson(json);
}

enum ControllerCommitFrequency { triggered, periodic, pressed, stream }
