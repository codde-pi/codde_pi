import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/dialogs/sideload_warning_dialog.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/core/loading_progress_store.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:flame_tiled/flame_tiled.dart' as tiled;
import 'package:path_provider/path_provider.dart';

// ===========================================================================
// FILE MANAGEMENT
// ===========================================================================

String getControllerName({required String path}) {
  return p.join(path, "layout", "controller.tmx");
}

String getExecutablePath({required String workDir}) {
  return "sudo python3 ${p.join(workDir, 'main.py')}"; // TODO: remove sydo
}

String getRemotePath({required String pushDir, required String projectName}) {
  return p.join(pushDir, projectName);
}

Future<String> getAssetControllerContent() async {
  // TODO: clean tree
  return await rootBundle.loadString('assets/samples/socketio/controller.tmx');
}

Future<FileEntity?> createControllerMap(
    BuildContext context, String workDir) async {
  final dummyIsDirectory =
      await getBackend().dirExists(p.join(workDir, "layout"));
  if (!dummyIsDirectory) {
    await getBackend().mkdir(p.dirname(workDir));
    logger.d('CREATING DIR: ${p.dirname(workDir)}');
  } else {
    logger.d('NOPE');
  }

  final map = ControllerMap.create(context: context, path: workDir);
  return await map.createMap();
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

Future sideloadProjectDialog(BuildContext context,
    {required Project project}) async {
  final store = LoadingProgressStore();
  GetIt.I.registerSingleton(store);
  await showDialog(
    context: context,
    builder: (context) => Observer(
        builder: (_) => AlertDialog(
              title: const Text("Sideloading"),
              content: store.noProgress
                  ? Text(
                      "Are you sure you want to sideload this project? Every data on destination will be overwritten.\nDEVICE: ${project.device.name}\nWORKING DIR: ${project.remoteDestination}")
                  : LinearProgressIndicator(
                      value: store.progress,
                    ),
              actions: [
                TextButton(
                  onPressed: () =>
                      store.noProgress ? Navigator.of(context).pop() : null,
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                    onPressed: () => store.noProgress
                        ? sideloadProject(context, project: project)
                        : null,
                    child: const Text('OK')),
              ],
            )),
  );
  GetIt.I.unregister<LoadingProgressStore>();
}

Future sideloadProject(BuildContext context, {required Project project}) async {
  final CoddeBackend currentBackend = getBackend();
  assert(project.device.host != null, 'Host project should not be null');
  final CoddeBackend targetBackend = CoddeBackend(BackendLocation.server,
      credentials: project.device.host!.toCredentials());
  await targetBackend.open();
  final store = GetIt.I.get<LoadingProgressStore>();
  // TODO: stream
  await currentBackend
      .listChildren(project.workDir, recursive: true)
      .then((value) => value.forEach((e) async {
            if (e.isDir) {
              targetBackend.mkdir(p.joinAll([
                project.remoteDestination!,
                project.name,
                p.relative(e.path, from: project.workDir)
              ]));
            } else {
              targetBackend.save(
                  p.joinAll([
                    project.remoteDestination!,
                    project.name,
                    p.relative(e.path, from: project.workDir)
                  ]),
                  await currentBackend.readSync(e.path));
            }
            store.progress = store.progress + 1 / value.length;
          }))
      .then((value) => targetBackend.close());
}

Future downloadProject(BuildContext context, {required Project project}) async {
  final CoddeBackend refBackend = CoddeBackend(BackendLocation.server,
      credentials: project.device.host!.toCredentials());
  assert(project.device.host != null, 'Host project should not be null');
  final CoddeBackend targetBackend = getBackend();
  await targetBackend.open();
  final store = GetIt.I.get<LoadingProgressStore>();
  await refBackend
      .listChildren(project.workDir, recursive: true)
      .then((value) => value.forEach((e) async {
            if (e.isDir) {
              targetBackend.mkdir(p.joinAll([
                project.remoteDestination!,
                project.name,
                p.relative(e.path, from: project.workDir)
              ]));
            } else {
              targetBackend.save(
                  p.joinAll([
                    project.remoteDestination!,
                    project.name,
                    p.relative(e.path, from: project.workDir)
                  ]),
                  await refBackend.readSync(e.path));
            }
            store.progress = store.progress + 1 / value.length;
          }))
      .then((value) => targetBackend.close());
}

Future downloadProjectDialog(BuildContext context,
    {required Project project}) async {
  final store = LoadingProgressStore();
  GetIt.I.registerSingleton(store);
  await showDialog(
    context: context,
    builder: (context) => Observer(
        builder: (_) => AlertDialog(
              title: const Text("Downloading"),
              content: store.noProgress
                  ? Text(
                      "Are you sure you want to download code of this project from embedded device? Every data will be overwritten.\nDEVICE: ${project.device.name}\nWORKING DIR: ${project.remoteDestination}")
                  : LinearProgressIndicator(
                      value: store.progress,
                    ),
              actions: [
                TextButton(
                  onPressed: () =>
                      store.noProgress ? Navigator.of(context).pop() : null,
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                    onPressed: () => store.noProgress
                        ? downloadProject(context, project: project)
                        : null,
                    child: const Text('OK')),
              ],
            )),
  );
  GetIt.I.unregister<LoadingProgressStore>();
}

/// Delete project data, files and database
Future<void> deleteProject(BuildContext context, Project project) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Delete project !"),
            content: Text(
                "Are you sure deleting this project? This action will erase all files contained in ${project.workDir} directory and cannot be undone"),
            actions: [
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL')),
              ElevatedButton(
                  onPressed: () async {
                    final backend = CoddeBackend(
                        project.device.host != null
                            ? BackendLocation.server
                            : BackendLocation.local,
                        credentials: project.device.host?.toCredentials());
                    try {
                      await backend.open();
                      await backend.removeDir(project.workDir);
                      await Hive.box<Project>(projectsBox).delete(project.key);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Unable to delete project : $e"),
                      ));
                    } finally {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('DELETE'))
            ],
          ));
}

Future<Project> addExistingProject(context, String name,
    {required Device device, required String path}) async {
  final instance = Project(
      dateCreated: DateTime
          .now(), // TODO: ideally, pick the project creation date in directory metadata
      dateModified: DateTime.now(),
      name: name,
      device: device,
      workDir: path);
  await Hive.box<Project>(projectsBox).add(instance);
  return instance;
}

//TODO: find right syntax
/* T getOrRegister<T>(T instance) {
  if (!GetIt.I.isRegistered<T>()) {
    return GetIt.I.registerSingleton<T>(instance);
  } else {
    return GetIt.I.get<Object>();
  }
} */

String getUserHome(String username) {
  return "/home/$username";
}

tiled.Property<int> turnDeviceIntoProperty(int deviceId) {
  return tiled.Property(
    name: 'deviceId',
    type: tiled.PropertyType.int,
    value: deviceId,
  );
}

getProjectExecutable(Project project) {
  return p.join(project.workDir, 'main.py');
}

Future<int> addDevice(Device device) async {
  return await Hive.box<Device>('devices').add(device);
}

getHostAddrFromDeviceAddr(String str) {
  return str.split(":").first;
}

Future<String> getAbsoluteLocalFilePath(String name) async {
  return await getApplicationSupportDirectory()
      .then((value) => p.join(value.path, name));
}

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
