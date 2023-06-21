// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 0;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      dateCreated: fields[0] as DateTime,
      dateModified: fields[1] as DateTime,
      name: fields[2] as String,
      host: fields[3] as Host?,
      description: fields[4] == null ? '' : fields[4] as String?,
      controlledDevice: fields[5] as Device?,
      path: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dateCreated)
      ..writeByte(1)
      ..write(obj.dateModified)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.host)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.controlledDevice)
      ..writeByte(6)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
