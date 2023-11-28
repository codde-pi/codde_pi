import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/sideload_warning_dialog.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;

// ===========================================================================
// FILE MANAGEMENT
// ===========================================================================

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

bool isShellFile(String file) {
  return file.endsWith(".sh");
}

bool isInTreeExecutable(String file) {
  return isControllerFile(file) ||
      (isPythonFile(file) && (file == "main.py" || file == "__main__.py"));
}

String runPrefix(String file, {bool inCwd = false}) {
  final exec = inCwd ? p.basename(file) : file;
  if (isPythonFile(file)) {
    return "python $exec";
  } else if (isShellFile(file))
    return "./$exec";
  else
    return exec;
}

// ===========================================================================
// PROJECT MANAGEMENT
// ===========================================================================

CoddeBackend getBackend() {
  try {
    return GetIt.I.get<CoddeBackend>();
  } on WaitingTimeOutException {
    throw NoRegsiteredBackendException();
  }
}

Future<String> createHostDir(Host host, String path) async {
  var backend =
      CoddeBackend(BackendLocation.server, credentials: host.toCredentials());
  await backend.open();
  final finalPath = await backend.mkdir(path);
  backend.close();
  return finalPath.path;
}

void reloadProject(BuildContext context, Project project) {
  showDialog(
      context: context,
      builder: (context) => SideloadWarningDialog(
            project: project,
          ));
}

Future sideloadProject(BuildContext context,
    {required Project project, String? destinationPath = "~"}) async {
  final CoddeBackend currentBackend = getBackend();
  assert(project.host != null, 'Host project should not be null');
  final CoddeBackend targetBackend = CoddeBackend(BackendLocation.server,
      credentials: project.host!.toCredentials());
  targetBackend.open();
  currentBackend
      .listChildren(project.path, recursive: true)
      .then((value) => value.forEach((e) async {
            if (e.isDir) {
              targetBackend.mkdir(p.joinAll([
                destinationPath!,
                project.name,
                p.relative(e.path, from: project.path)
              ]));
            } else {
              targetBackend.save(
                  p.joinAll([
                    destinationPath!,
                    project.name,
                    p.relative(e.path, from: project.path)
                  ]),
                  await currentBackend.readSync(e.path));
            }
          }));
}
