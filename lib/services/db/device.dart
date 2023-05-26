import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:hive/hive.dart';

part 'device.g.dart';

@HiveType(typeId: 3)
class Device extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DeviceProtocol protocol;

  @HiveField(2)
  DeviceModel model;

  @HiveField(3)
  String? address;

  Device(
      {required this.name,
      required this.protocol,
      required this.model,
      required this.address});
}
