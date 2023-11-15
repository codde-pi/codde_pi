import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

String getControllerName(String projectPath) {
  return p.join(projectPath, "${p.basename(projectPath)}.tmx");
}

Future<String> getAssetControllerContent() async {
  // TODO: clean tree
  return await rootBundle.loadString('assets/samples/socketio/controller.tmx');
}

Future<FileEntity?> createControllerMap(
  BuildContext context,
  String path,
) async {
  final map = ControllerMap.create(context: context, path: path);
  final api = ControllerWidgetApi(map: map);
  return await api.createMap();
}

bool isPythonFile(String file) {
  return file.endsWith('.py');
}

bool isControllerFile(String file) {
  return file.endsWith('.tmx');
}

bool isExecutable(String file) {
  return isControllerFile(file) ||
      (isPythonFile(file) && (file == "main.py" || file == "__main__.py"));
}
