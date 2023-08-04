import 'package:freezed_annotation/freezed_annotation.dart';

part 'controller_api_attribute.freezed.dart';
part 'controller_api_attribute.g.dart';

@freezed
class ControllerApiAttribute with _$ControllerApiAttribute {
  const factory ControllerApiAttribute(
      {String? key,
      required String valueType,
      Object? defaultValue}) = _ControllerApiAttribute;

  factory ControllerApiAttribute.fromJson(Map<String, Object?> json) =>
      _$ControllerApiAttributeFromJson(json);
}
