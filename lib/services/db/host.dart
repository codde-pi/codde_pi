import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:hive/hive.dart';

part 'host.g.dart';

@HiveType(typeId: 2)
class Host extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String ip;

  @HiveField(2)
  String pswd;

  @HiveField(3, defaultValue: 22)
  int? port;

  @HiveField(4)
  String user;

  Host(
      {required this.name,
      required this.ip,
      required this.user,
      required this.pswd,
      this.port});

  Device toDevice() {
    return Device(
        name: name,
        model: DeviceModel.sbc,
        address: ip,
        protocol: DeviceProtocol.socketio);
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
