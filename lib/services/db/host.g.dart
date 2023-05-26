// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostAdapter extends TypeAdapter<Host> {
  @override
  final int typeId = 2;

  @override
  Host read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Host(
      name: fields[0] as String,
      ip: fields[1] as String,
      pswd: fields[2] as String,
      port: fields[3] == null ? 22 : fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Host obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ip)
      ..writeByte(2)
      ..write(obj.pswd)
      ..writeByte(3)
      ..write(obj.port);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
