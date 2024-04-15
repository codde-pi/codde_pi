import 'package:hive/hive.dart';

part 'project_type.g.dart';

@HiveType(typeId: 6)
enum ProjectType {
  @HiveField(0)
  codde_pi,
  @HiveField(1)
  controller
}
