import 'package:codde_backend/codde_backend.dart';

import 'device.dart';
import 'host.dart';
import 'package:hive/hive.dart';

import 'project_type.dart';

part 'project.g.dart';

@HiveType(typeId: 0)
class Project extends HiveObject {
  @HiveField(0)
  DateTime dateCreated;

  @HiveField(1)
  DateTime dateModified;

  @HiveField(2)
  String name; // TODO:: remove

  @HiveField(3)
  Host? host;

  @HiveField(4, defaultValue: '')
  String? description;

  @HiveField(5)
  Device? controlledDevice;

  @HiveField(6)
  String path;

  @HiveField(7, defaultValue: ProjectType.controller)
  ProjectType type;

  @HiveField(8, defaultValue: [])
  List<FileEntity> executables;

  Project(
      {required this.dateCreated,
      required this.dateModified,
      required this.name,
      this.host,
      this.description,
      this.controlledDevice,
      this.type = ProjectType.controller,
      this.executables = const <FileEntity>[],
      required this.path});

  bool get isRemote => host != null;

  Map<String, dynamic> toJson() {
    return {
      'date_created': dateCreated,
      'date_modified': dateModified,
      'name': name,
      'description': description,
      'repo': host != null ? host!.toJson() : {},
      'path': path
    };
  }

  Project copyWithJson(Map<String, dynamic> map) {
    return Project(
        controlledDevice: map["controlledDevice"] ?? controlledDevice,
        dateCreated: map["dateCreated"] ?? dateCreated,
        dateModified: map["dateCreated"] ?? dateModified,
        description: map["description"] ?? description,
        host: map["host"] ?? host,
        name: map["name"] ?? name,
        path: map["path"] ?? path);
  }

  static Project fromJson(Map<String, dynamic> map) {
    assert(map["name"] != null);
    assert(map["path"] != null);
    final project = Project(
        dateCreated: map["dateCreated"] ?? DateTime.now(),
        dateModified: map["dateModified"] ?? DateTime.now(),
        controlledDevice: map["controlledDevice"],
        description: map['description'],
        host: map["host"],
        name: map["name"],
        path: map["path"]);
    return project;
  }
}
