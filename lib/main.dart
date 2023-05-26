import 'package:codde_pi/app/pages/home.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO: replace with this box name
const projectsBox = 'userProjects';

void main() async {
  await Hive.initFlutter(); // TODO: find right location
  Hive
    ..registerAdapter(DeviceModelAdapter())
    ..registerAdapter(DeviceProtocolAdapter())
    ..registerAdapter(DeviceAdapter());
  await Hive.openBox<Device>('devices');
  Hive.registerAdapter(HostAdapter());
  await Hive.openBox<Host>('hosts');
  Hive.registerAdapter(ProjectAdapter());
  await Hive.openBox<Project>(projectsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C.O.D.D.E. Pi®',
      theme: cddTheme,
      darkTheme: cddTheme,
      home: Home(),
      themeMode: ThemeMode.system,
    );
  }
}
