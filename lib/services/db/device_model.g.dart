// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceModelAdapter extends TypeAdapter<DeviceModel> {
  @override
  final int typeId = 4;

  @override
  DeviceModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeviceModel.sbc;
      case 1:
        return DeviceModel.arduino;
      case 2:
        return DeviceModel.pico;
      case 3:
        return DeviceModel.unknown;
      default:
        return DeviceModel.sbc;
    }
  }

  @override
  void write(BinaryWriter writer, DeviceModel obj) {
    switch (obj) {
      case DeviceModel.sbc:
        writer.writeByte(0);
        break;
      case DeviceModel.arduino:
        writer.writeByte(1);
        break;
      case DeviceModel.pico:
        writer.writeByte(2);
        break;
      case DeviceModel.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceProtocolAdapter extends TypeAdapter<DeviceProtocol> {
  @override
  final int typeId = 5;

  @override
  DeviceProtocol read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeviceProtocol.socket;
      case 1:
        return DeviceProtocol.socketio;
      case 2:
        return DeviceProtocol.usb;
      case 3:
        return DeviceProtocol.bluetooth;
      case 4:
        return DeviceProtocol.http;
      default:
        return DeviceProtocol.socket;
    }
  }

  @override
  void write(BinaryWriter writer, DeviceProtocol obj) {
    switch (obj) {
      case DeviceProtocol.socket:
        writer.writeByte(0);
        break;
      case DeviceProtocol.socketio:
        writer.writeByte(1);
        break;
      case DeviceProtocol.usb:
        writer.writeByte(2);
        break;
      case DeviceProtocol.bluetooth:
        writer.writeByte(3);
        break;
      case DeviceProtocol.http:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceProtocolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
