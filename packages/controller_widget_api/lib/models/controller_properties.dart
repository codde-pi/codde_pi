import 'package:codde_com/codde_com.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'controller_properties.g.dart';

@JsonSerializable()
class ControllerProperties extends Equatable {
  CoddeProtocol protocol;
  String? deviceId;
  String? executable;

  ControllerProperties(
      {required this.protocol, this.deviceId, this.executable});

  @override
  List<Object?> get props => [protocol, deviceId, executable];

  ControllerProperties copyWith(
    CoddeProtocol? protocol,
    String? deviceId,
    String? executable,
  ) {
    return ControllerProperties(
        protocol: protocol ?? this.protocol,
        deviceId: deviceId ?? this.deviceId,
        executable: executable ?? this.executable);
  }

  /// Deserializes the given [JsonMap] into a [ControllerMap].
  static ControllerProperties fromJson(Map<String, dynamic> json) =>
      _$ControllerPropertiesFromJson(json);

  /// Converts this [ControllerMap] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerPropertiesToJson(this);
}
