import 'package:codde_pi/app/pages/codde/codde.dart';
import 'package:codde_pi/app/pages/home.dart';
import 'package:codde_pi/app/pages/settings/settings.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/project_type.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO: replace with this box name
const projectsBox = 'userProjects';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Hive.initFlutter(); // TODO: find right location
  Hive
    ..registerAdapter(DeviceModelAdapter())
    ..registerAdapter(DeviceAdapter());
  await Hive.openBox<Device>('devices');
  Hive.registerAdapter(HostAdapter());
  await Hive.openBox<Host>('hosts');
  Hive
    ..registerAdapter(ProjectTypeAdapter())
    ..registerAdapter(ProjectAdapter());
  await Hive.openBox<Project>(projectsBox);
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'C.O.D.D.E. Pi®',
      theme: cddTheme,
      darkTheme: cddTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/codde': (context) => Codde(),
        '/controller': (_) => CoddeController(),
        '/settings': (_) => Settings(),
        // '/controller/editor': (_) => EditControllerPage(path: path)
        // '/codde/runner': (_) => CoddeRunner(exec)
      },
    );
  }
}
