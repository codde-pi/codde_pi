import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 0)
class Project extends HiveObject {
  @HiveField(0)
  DateTime dateCreated;

  @HiveField(1)
  DateTime dateModified;

  @HiveField(2)
  String name;

  @HiveField(3)
  Host? host;

  @HiveField(4, defaultValue: '')
  String? description;

  @HiveField(5)
  Device? controlledDevice;

  @HiveField(6)
  String path;

  Project(
      {required this.dateCreated,
      required this.dateModified,
      required this.name,
      this.host,
      this.description,
      this.controlledDevice,
      required this.path});

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
