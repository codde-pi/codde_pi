import 'package:codde_pi/services/db/device_model.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'device.g.dart';

@HiveType(typeId: 3)
class Device extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Protocol protocol;

  @HiveField(2)
  DeviceModel model;

  @HiveField(3)
  String? address;

  @HiveField(4)
  String uid;

  Device(
      {String? uid,
      required this.name,
      required this.protocol,
      required this.model,
      required this.address})
      : uid = uid ?? const Uuid().v4();
}
