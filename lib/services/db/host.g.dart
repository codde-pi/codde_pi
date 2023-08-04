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
      addr: fields[1] as String,
      user: fields[4] as String,
      pswd: fields[2] as String,
      port: fields[3] == null ? 22 : fields[3] as int?,
      uid: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Host obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.addr)
      ..writeByte(2)
      ..write(obj.pswd)
      ..writeByte(3)
      ..write(obj.port)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.uid);
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
