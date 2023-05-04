import 'dart:isolate';

import 'package:codde_pi/core/play_controller/views/play_controller_page.dart';
import 'package:codde_pi/services/db/objects.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter('/home/matt/Projects/codde_pi/');
  Hive
    ..registerAdapter(ProjectAdapter())
    ..registerAdapter(DeviceAdapter())
    ..registerAdapter(DeviceModelAdapter())
    ..registerAdapter(DeviceDiagramAdapter())
    ..registerAdapter(RepoAdapter())
    ..registerAdapter(SSHDeviceAdapter());
  await Hive.openBox('projects');
  runApp(const MyApp());
  await Isolate.run(save);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C.O.D.D.E. Pi',
      theme: cddTheme,
      darkTheme: cddTheme,
      home: PlayControllerPage(), // EditControllerPage(),
    );
  }
}

Future<void> save() async {
  var count = 0.0;
  bool flag = true;

  var futureThatStopsIt = Future.delayed(const Duration(seconds: 5), () {
    flag = false;
  });

  var futureWithTheLoop = () async {
    while (flag) {
      count++;
      print("going on: $count");
      await Future.delayed(const Duration(seconds: 1));
    }
  }();

  await Future.wait([futureThatStopsIt, futureWithTheLoop]);
  print('total $count');
}

/*void main() async {
  ThemeData themeData = ThemeData(
    fontFamily: 'FiraCode',
    primaryColor: foreground,
    backgroundColor: background,
    scaffoldBackgroundColor: background,
  );
  return runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const Scaffold(body: Editor(path: './tests/socket.py'))));
}*/
