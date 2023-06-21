import 'package:hive/hive.dart';

part 'device_model.g.dart';

@HiveType(typeId: 4)
enum DeviceModel {
  @HiveField(0)
  sbc,
  @HiveField(1)
  arduino,
  @HiveField(2)
  pico,
  @HiveField(3)
  unknown,
}

@HiveType(typeId: 5)
enum DeviceProtocol {
  @HiveField(0)
  socket,
  @HiveField(1)
  socketio,
  @HiveField(2)
  usb,
  @HiveField(3)
  bluetooth,
  @HiveField(4)
  http
}
