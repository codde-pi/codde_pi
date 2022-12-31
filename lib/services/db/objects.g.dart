// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

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
      fields[0] as DateTime,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as Repo,
      fields[4] as String,
      fields[5] as Device,
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dateCreated)
      ..writeByte(1)
      ..write(obj.dateModified)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.repo)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.device);
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

class RepoAdapter extends TypeAdapter<Repo> {
  @override
  final int typeId = 1;

  @override
  Repo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repo(
      fields[0] as Device,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Repo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.device)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SSHDeviceAdapter extends TypeAdapter<SSHDevice> {
  @override
  final int typeId = 2;

  @override
  SSHDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SSHDevice(
      fields[0] as String,
      fields[1] as String,
      port: fields[2] == null ? 22 : fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SSHDevice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ip)
      ..writeByte(1)
      ..write(obj.pswd)
      ..writeByte(2)
      ..write(obj.port);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SSHDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceAdapter extends TypeAdapter<Device> {
  @override
  final int typeId = 3;

  @override
  Device read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Device(
      fields[0] as String,
      fields[2] as DeviceModel,
      sshDevice: fields[1] as SSHDevice?,
    );
  }

  @override
  void write(BinaryWriter writer, Device obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sshDevice)
      ..writeByte(2)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceDiagramAdapter extends TypeAdapter<DeviceDiagram> {
  @override
  final int typeId = 4;

  @override
  DeviceDiagram read(BinaryReader reader) {
    return DeviceDiagram();
  }

  @override
  void write(BinaryWriter writer, DeviceDiagram obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceDiagramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceModelAdapter extends TypeAdapter<DeviceModel> {
  @override
  final int typeId = 5;

  @override
  DeviceModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeviceModel.rpi3Bp;
      case 1:
        return DeviceModel.rpi4;
      case 2:
        return DeviceModel.rpiPico;
      case 3:
        return DeviceModel.unknown;
      default:
        return DeviceModel.rpi3Bp;
    }
  }

  @override
  void write(BinaryWriter writer, DeviceModel obj) {
    switch (obj) {
      case DeviceModel.rpi3Bp:
        writer.writeByte(0);
        break;
      case DeviceModel.rpi4:
        writer.writeByte(1);
        break;
      case DeviceModel.rpiPico:
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
