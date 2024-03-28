import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'host.g.dart';

@HiveType(typeId: 2)
class Host extends HiveObject {
  @HiveField(0)
  String name;

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

  Host(
      {required this.name,
      required this.addr,
      required this.user,
      required this.pswd,
      this.port,
      String? uid})
      : uid = uid ?? const Uuid().v4();

  Device toDevice() {
    return Device(
      uid: uid,
      name: name,
      model: DeviceModel.sbc,
      address: addr,
      protocol: Protocol.webSocket,
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  SFTPCredentials toCredentials() {
    return SFTPCredentials(host: addr, pswd: pswd, user: user);
  }
}
