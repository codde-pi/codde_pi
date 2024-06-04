import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/forms/device_host_form.dart';
import 'package:codde_pi/components/project_launcher/store/project_launcher_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/database.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/project_launcher_utils.dart';

class ProjectLauncher extends StatelessWidget {
  final projNameController = TextEditingController();
  final descController = TextEditingController();
  final store = ProjectLauncherStore();

  ProjectLauncher({super.key});

  // TODO: add description
  void createProject(BuildContext context, {required String title}) {
    if (projNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Project name cannot be empty")));
    }
    store.selectedDevice != null
        ? createProjectFromScratch(
            context,
            title,
            device: store.selectedDevice!,
          ).then((value) => goToProject(context: context, instance: value))
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No device selected")));
  }

  void setHost(Host host) {
    Hive.box("devices").get(store.selectedDevice?.key).host = host;
    store
        .setDevice(Hive.box<Device>("devices").get(store.selectedDevice?.key)!);
  }

  bool get validable => (store.selectedDevice != null &&
      (store.selectedDevice!.host != null || store.hostLater));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure project"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          Observer(
            builder: (context) => ElevatedButton(
                onPressed: validable
                    ? () {
                        if (store.validate()) {
                          createProject(context,
                              title: projNameController.text);
                        }
                      }
                    : null,
                child: const Text('CREATE')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(widgetGutter),
            child: Form(
              key: store.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: projNameController,
                    decoration: const InputDecoration(
                        hintText: 'Project name', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: widgetGutter),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                        hintText: 'Description', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: widgetGutter),
                  const Text(
                      "Configure a CODDE Pi project with your code and specs then deploy it on your robot"),
                  const SizedBox(height: widgetGutter),
                  ValueListenableBuilder(
                    valueListenable: Hive.box<Device>('devices').listenable(),
                    builder: (context, box, widget) => box.values.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              final e = box.values.elementAt(index);
                              return RadioMenuButton<Device>(
                                value: box.values.elementAt(index),
                                groupValue: store.selectedDevice,
                                onChanged: (d) {
                                  store.setDevice(d!);
                                  // refreshHosts(context);
                                },
                                child: Row(children: [
                                  Text(
                                    e.name,
                                    /* style:
                                          Theme.of(context).textTheme.bodyLarge, */
                                  ),
                                  const SizedBox(width: widgetGutter / 2),
                                  Text(e.addr),
                                  if (e.host == null) ...[
                                    const SizedBox(width: widgetGutter / 2),
                                    Text(
                                      "missing host credentials",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                  ]
                                ]),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: widgetGutter),
                  OutlinedButton(
                      onPressed: () async {
                        final res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ControlledDeviceDialog()),
                        );
                        if (res != null) {
                          await addDevice(res).then((value) {
                            store.setDevice(res);
                          });
                        }
                      },
                      child: const Text('NEW DEVICE')),
                  if (store.selectedDevice?.model == DeviceModel.sbc &&
                      store.selectedDevice?.host == null) ...[
                    const SizedBox(height: widgetGutter),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                                "Configure SFTP credentials and project remote location"),
                          ),
                          ElevatedButton(
                            onPressed: () => createProject(context,
                                title: projNameController.text),
                            child: const Text('LATER'),
                          ),
                        ]),
                    if (!store.hostLater) ...[
                      const SizedBox(height: widgetGutter),
                      DeviceHostForm(
                          device: store.selectedDevice!,
                          cancel: () => null,
                          validate: (host) {}),
                    ]
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
