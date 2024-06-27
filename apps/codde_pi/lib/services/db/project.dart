import 'package:codde_pi/core/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

import 'device.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;

part 'project.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Project extends HiveObject {
  @HiveField(0)
  DateTime dateCreated;

  @HiveField(1)
  DateTime dateModified;

  @HiveField(2)
  String name; // used on Radicle repo

  @HiveField(4, defaultValue: '')
  String? description; // used on Radicle repo

  @HiveField(5)
  Device device;

  @HiveField(6)
  String workDir;
  /* Future<String> get workDir async => p.join(
      await getApplicationSupportDirectory().then((value) => value.path), name); */

  @HiveField(9, defaultValue: false)
  bool triggerExecutable;

  @HiveField(10, defaultValue: '')
  String repo;

  @HiveField(11, defaultValue: false)
  bool flashed;

  @HiveField(12, defaultValue: false)
  bool published;

  bool get sftpHosting => device.host != null;

  String? get pushDir => sftpHosting ? device.host!.pushDir : null;

  String? get remoteDestination => sftpHosting
      ? getRemotePath(pushDir: device.host!.pushDir, projectName: name)
      : null;

  Project(
      {required this.dateCreated,
      required this.dateModified,
      required this.name,
      this.description,
      required this.device,
      this.triggerExecutable = false,
      required this.workDir,
      this.flashed = false,
      this.published = false,
      this.repo = ''});

  /// Connect the generated [_$PersonFromJson] function to the [fromJson]
  /// factory.
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// Connect the generated [_$ProjectToJson] function to the [toJson] method.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
