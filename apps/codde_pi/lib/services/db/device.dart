import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'device.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Device extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Protocol protocol;

  @HiveField(2)
  DeviceModel model;

  @HiveField(3)
  String addr;

  @HiveField(4)
  String uid;

  @JsonKey(includeFromJson: true, includeToJson: false)
  @HiveField(5)
  Host? host;

  @HiveField(6, defaultValue: '')
  String repo;

  @HiveField(7, defaultValue: false)
  bool published;

  Device(
      {String? uid,
      required this.name,
      required this.protocol,
      required this.model,
      required this.addr,
      this.host,
      this.published = false,
      this.repo = ''})
      : uid = uid ?? const Uuid().v4();

  Device.andHost(
      {required this.name,
      required this.addr,
      required this.protocol,
      required this.model,
      String? uid,
      required String user,
      required String pswd,
      String? pushDir,
      int? port,
      this.published = false,
      this.repo = ''})
      : uid = uid ?? const Uuid().v4() {
    host = toHost(user: user, pswd: pswd, port: port, pushDir: pushDir);
  }

  Host toHost(
      {required String user,
      required String pswd,
      String? pushDir,
      int? port}) {
    return Host(
        addr: addr.split(":").first,
        user: user,
        pswd: pswd,
        port: port,
        pushDir: pushDir,
        uid: uid);
  }

  /// Connect the generated [_$PersonFromJson] function to the [fromJson]
  /// factory.
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// Connect the generated [_$DeviceToJson] function to the [toJson] method.
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
