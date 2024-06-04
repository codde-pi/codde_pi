import 'package:codde_pi/app/pages/codde/codde.dart';
import 'package:codde_pi/app/pages/home.dart';
import 'package:codde_pi/app/pages/settings/settings.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/services/db/protocol_adapter.dart';
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
    ..registerAdapter(DeviceAdapter())
    ..registerAdapter(ProtocolAdapter());
  Hive.registerAdapter(HostAdapter());
  await Hive.openBox<Device>('devices');
  // await Hive.openBox<Host>('hosts'); // TODO: useful ?
  Hive.registerAdapter(ProjectAdapter());
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
        '/coddeOverview': (_) => CoddeOverview(),
        '/settings': (_) => Settings(),
        // '/controller/editor': (_) => EditControllerPage(path: path)
        // '/codde/runner': (_) => CoddeRunner(exec)
      },
    );
  }
}

// TODO: automate homepage & author
final List<(String, String, String)> deps = [
  (
    "CODDE Protocol",
    "https://github.com/codde-pi/flutter_codde_protocol",
    "Mathis Lecomte"
  ),
  ("Flame", "https://github.com/flame-engine/flame", "FlutterFire"),
  ("Tiled.dart", "https://github.com/flame-engine/flame_tiled", "FlutterFire"),
  (
    "cupertino_icons",
    "https://pub.dev/packages/cupertino_icons",
    "Flutter team"
  ),
  ("cupertino_icons", "https://pub.dev/packages/cupertino_icons", ""),
  ("args", "https://pub.dev/packages/args", ""),
  ("screenshot", "https://pub.dev/packages/screenshot", ""),
  ("path", "https://pub.dev/packages/path", ""),
  ("file_manager", "https://pub.dev/packages/file_manager", ""),
  ("json_serializable", "https://pub.dev/packages/", ""),
  ("equatable", "https://pub.dev/packages/", ""),
  ("enum_to_string", "https://pub.dev/packages/", ""),
  ("glob", "https://pub.dev/packages/", ""),
  ("freezed", "https://pub.dev/packages/", ""),
  ("freezed_annotation", "https://pub.dev/packages/", ""),
  ("json_annotation", "https://pub.dev/packages/", ""),
  ("xml", "https://pub.dev/packages/", ""),
  ("flutter_svg", "https://pub.dev/packages/", ""),
  ("google_fonts", "https://pub.dev/packages/", ""),
  ("flutter_treeview", "https://pub.dev/packages/", ""),
  ("file_picker", "https://pub.dev/packages/", ""),
  ("flutter_markdown", "https://pub.dev/packages/", ""),
  ("flame", "https://pub.dev/packages/", ""),
  ("flame_svg", "https://pub.dev/packages/", ""),
  ("flame_tiled", "https://pub.dev/packages/", ""),
  ("xterm", "https://pub.dev/packages/", ""),
  ("dartssh2", "https://pub.dev/packages/", ""),
  ("webview_flutter", "https://pub.dev/packages/", ""),
  ("patterns_canvas", "https://pub.dev/packages/", ""),
  ("mime", "https://pub.dev/packages/", ""),
  ("intl", "https://pub.dev/packages/", ""),
  ("mime_type", "https://pub.dev/packages/", ""),
  ("isolate_handler", "https://pub.dev/packages/", ""),
  ("provider", "https://pub.dev/packages/", ""),
  ("socket_io_client", "https://pub.dev/packages/", ""),
  ("hive", "https://pub.dev/packages/", ""),
  ("hive_flutter", "https://pub.dev/packages/", ""),
  ("bloc", "https://pub.dev/packages/", ""),
  ("flutter_bloc", "https://pub.dev/packages/", ""),
  ("mobx", "https://pub.dev/packages/", ""),
  ("flutter_mobx", "https://pub.dev/packages/", ""),
  ("mobx_codegen", "https://pub.dev/packages/", ""),
  ("get_it", "https://pub.dev/packages/", ""),
  ("network_info_plus", "https://pub.dev/packages/", ""),
  ("arp_scanner", "https://pub.dev/packages/", ""),
  ("lan_scanner", "https://pub.dev/packages/", ""),
  ("after_layout", "https://pub.dev/packages/", ""),
  ("uuid", "https://pub.dev/packages/", ""),
  ("dart_ping", "https://pub.dev/packages/", ""),
  ("carousel_slider", "https://pub.dev/packages/", ""),
  ("backdrop", "https://pub.dev/packages/", ""),
  ("logger", "https://pub.dev/packages/", ""),
  ("flutter_codde_protocol", "https://pub.dev/packages/", ""),
  ("flutter_staggered_grid_view", "https://pub.dev/packages/", ""),
  ("pie_chart", "https://pub.dev/packages/", ""),
  ("json_table", "https://pub.dev/packages/", ""),
  ("graphic", "https://pub.dev/packages/", ""),
  ("responsive_builder", "https://pub.dev/packages/", ""),
  ("ffigen", "https://pub.dev/packages/", ""),
  ("path_provider", "https://pub.dev/packages/", ""),
];
