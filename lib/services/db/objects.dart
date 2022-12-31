import 'package:hive/hive.dart';

part 'objects.g.dart';

@HiveType(typeId: 0)
class Project extends HiveObject {
  @HiveField(0)
  DateTime dateCreated;

  @HiveField(1)
  DateTime dateModified;

  @HiveField(2)
  String name;

  @HiveField(3)
  Repo repo;

  @HiveField(4)
  String description;

  @HiveField(5)
  Device device;

  Project(this.dateCreated, this.dateModified,
      this.name, this.repo, this.description,
      this.device);

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'date_created': dateCreated,
      'date_modified': dateModified,
      'name': name,
      'description': description,
      'repo': repo.toMap(),
    };
  }
}

@HiveType(typeId: 1)
class Repo extends HiveObject {

  @HiveField(0)
  Device device;

  @HiveField(1)
  String path;
  
  Repo(this.device, this.path);

  Map<String, dynamic> toMap() {
    return {};
  }
}

@HiveType(typeId: 2)
class SSHDevice extends HiveObject {
  @HiveField(0)
  String ip;

  @HiveField(1)
  String pswd;

  @HiveField(2, defaultValue: 22)
  int? port;

  SSHDevice(this.ip, this.pswd, {this.port});
}

@HiveType(typeId: 3)
class Device extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1, defaultValue: null)
  SSHDevice? sshDevice;

  @HiveField(2)
  DeviceModel model;

  Device(this.name, this.model, {this.sshDevice});

  Repo toRepo(String path) {
    return Repo(this, path);
  }
}

// TODO: SBCModel to diagram DICT


// TODO: Match with DeviceDiagram, not yet implemented
@HiveType(typeId: 4)
class DeviceDiagram extends HiveObject {
}

@HiveType(typeId: 5)
enum DeviceModel {
  @HiveField(0)
  rpi3Bp,

  @HiveField(1)
  rpi4,

  @HiveField(2)
  rpiPico,

  @HiveField(3)
  unknown,
}