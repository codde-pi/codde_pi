import 'package:codde_backend/codde_backend.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'host.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Host extends HiveObject {
  @HiveField(1)
  String addr;

  @HiveField(2)
  String pswd;

  @HiveField(3, defaultValue: 22)
  int? port;

  @HiveField(4)
  String user;

  @HiveField(5)
  String uid;

  @HiveField(6, defaultValue: "/home/root")
  String pushDir;

  Host(
      {required this.addr,
      required this.user,
      required this.pswd,
      String? pushDir,
      this.port,
      String? uid})
      : uid = uid ?? const Uuid().v4(),
        pushDir = pushDir ?? "/home/$user";

  SFTPCredentials toCredentials() {
    return SFTPCredentials(host: addr, pswd: pswd, user: user);
  }

  factory Host.fromDevice(
      {required String user,
      required String pswd,
      String? pushDir,
      required String addr,
      String? uid,
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
  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  /// Connect the generated [_$HostToJson] function to the [toJson] method.
  Map<String, dynamic> toJson() => _$HostToJson(this);
}
