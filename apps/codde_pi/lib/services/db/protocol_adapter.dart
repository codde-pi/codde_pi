import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:hive/hive.dart';

class ProtocolAdapter extends TypeAdapter<Protocol> {
  @override
  final int typeId = 5;

  @override
  Protocol read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Protocol.webSocket;
      case 1:
        return Protocol.bluetooth;
      case 2:
        return Protocol.usb;
      case 3:
        return Protocol.http;
      default:
        return Protocol.webSocket;
    }
  }

  @override
  void write(BinaryWriter writer, Protocol obj) {
    switch (obj) {
      case Protocol.webSocket:
        writer.writeByte(0);
        break;
      case Protocol.bluetooth:
        writer.writeByte(1);
        break;
      case Protocol.usb:
        writer.writeByte(2);
        break;
      case Protocol.http:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProtocolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
