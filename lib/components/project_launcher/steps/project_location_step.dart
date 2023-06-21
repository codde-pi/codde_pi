import 'dart:io';

import 'package:codde_pi/components/forms/ssh_host_form.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as pth;
import 'package:path_provider/path_provider.dart';

enum ProjectLocationType { internal, system, ssh }

class ProjectLocationStep extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProjectLocationStepState();
}

class ProjectLocationStepState extends State<ProjectLocationStep> {
  ProjectLocationType locationType = ProjectLocationType.internal;
  List<Host>? repoList;
  Device? controlledDevice;
  final pathController = TextEditingController();
  final listController = ScrollController();
  final ValueNotifier<Host?> selectedHost = ValueNotifier(null);
  bool openNewDeviceForm = false;

  void createDevice(Host host) {
    Hive.box<Host>('projects').add(host);
    openForm(false);
  }

  void openForm(bool value) {
    setState(() {
      openNewDeviceForm = value;
    });
  }

  void selectLocation(ProjectLocationType location) {
    setState(() {
      locationType = location;
      if (location == ProjectLocationType.ssh) {
        repoList = Hive.box<Host>('hosts').values.toList();
      }
    });
    listController.animateTo(
      listController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void selectHost(Host host) {
    selectedHost.value = host;
  }

  void openPath() async {
    String? selectedDirectory;
    if (locationType == ProjectLocationType.system) {
      selectedDirectory = await FilePicker.platform.getDirectoryPath();
    } else {
      //TODO: create awaitable Intent to pick folder from sftp
      print('todo');
    }
    if (selectedDirectory != null) pathController.text = selectedDirectory;
  }

  bool get creatable {
    return (pathController.text.isNotEmpty ||
            locationType == ProjectLocationType.internal) &&
        (selectedHost.value != null || locationType != ProjectLocationType.ssh);
  }

  void nextPage() async {
    String path;
    if (locationType != ProjectLocationType.internal) {
      path = pathController.text;
    } else {
      path =
          await getApplicationDocumentsDirectory().then((value) => value.path);
    }
    path = pth.join(path, context.read<ProjectLauncherCubit>().state.data.name);
    await Directory(path).create();
    context
        .read<ProjectLauncherCubit>()
        .feedData({"host": selectedHost.value, "path": path}, nextPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: listController,
      children: [
        ListTile(
          leading: Radio(
              value: ProjectLocationType.internal,
              groupValue: locationType,
              onChanged: (value) {
                selectLocation(value!);
              }),
          title: const Text("Internal app storage location"),
          trailing: const Icon(Icons.question_mark),
        ),
        ListTile(
          leading: Radio(
              value: ProjectLocationType.system,
              groupValue: locationType,
              onChanged: (value) {
                selectLocation(value!);
              }),
          title: const Text("System storage location"),
          trailing: const Icon(Icons.question_mark),
        ),
        ListTile(
          leading: Radio(
              value: ProjectLocationType.ssh,
              groupValue: locationType,
              onChanged: (value) {
                selectLocation(value!);
              }),
          title: const Text("Remote host location"),
          trailing: const Icon(Icons.question_mark),
        ),
        const VerticalDivider(
          thickness: 2.0,
          width: double.infinity,
        ),
        // TODO: create new ssh host option, and assign selectedHost value
        if (locationType == ProjectLocationType.ssh)
          ElevatedButton(
              onPressed: () => openForm(true), child: const Text('New Host')),
        if (locationType == ProjectLocationType.ssh && openNewDeviceForm)
          SSHHostForm(
              validate: createDevice,
              cancel: () => openForm(false)), // TODO: plug to SFTPCredentials
        if (locationType == ProjectLocationType.ssh && repoList != null) ...[
          for (var repo in repoList!)
            ValueListenableBuilder(
              valueListenable: selectedHost,
              builder: (context, index, widget) => ListTile(
                selected: selectedHost == repo,
                title: Text(repo.name),
                onTap: () => selectHost(repo),
              ),
            )
        ],
        if (locationType != ProjectLocationType.internal)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: pathController,
                ),
              ),
              OutlinedButton(
                  onPressed: () => openPath(), child: const Text('...'))
            ],
          ),
        ValueListenableBuilder(
          valueListenable: selectedHost,
          builder: (context, index, widget) => creatable
              ? ElevatedButton(
                  onPressed: () => nextPage(), child: const Text('continue'))
              : Container(),
        )
      ],
    );
  }
}
