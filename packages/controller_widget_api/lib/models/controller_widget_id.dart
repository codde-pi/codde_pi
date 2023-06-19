import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'controller_widget_id.freezed.dart';
part 'controller_widget_id.g.dart';

@freezed
class ControllerWidgetId with _$ControllerWidgetId {
  const factory ControllerWidgetId(
      {required ControllerClass class_, // toString <=> uid
      required String description,
      required String name,
      required List<ControllerApiAttribute> api,
      @Default(ControllerCommitFrequency.triggered)
      ControllerCommitFrequency commitFrequency}) = _ControllerWidgetId;

  factory ControllerWidgetId.fromJson(Map<String, Object?> json) =>
      _$ControllerWidgetIdFromJson(json);
}

@freezed
class ControllerApiAttribute with _$ControllerApiAttribute {
  const factory ControllerApiAttribute(
      {String? key,
      required String valueType,
      Object? defaultValue}) = _ControllerApiAttribute;

  factory ControllerApiAttribute.fromJson(Map<String, Object?> json) =>
      _$ControllerApiAttributeFromJson(json);
}

enum ControllerCommitFrequency { triggered, periodic }
