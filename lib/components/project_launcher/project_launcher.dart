import 'package:codde_pi/components/dialogs/new_host_dialog.dart';
import 'package:codde_pi/components/project_launcher/store/project_launcher_store.dart';
import 'package:codde_pi/services/db/project_type.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProjectLauncher extends StatelessWidget {
  final projNameController = TextEditingController();
  final store = ProjectLauncherStore();

  ProjectLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure new Project"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
      ),
      body: Observer(
        builder: (context) => Form(
          key: store.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(widgetGutter),
                child: TextFormField(
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
              ),
              const SizedBox(height: widgetGutter),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    onTap: () => store.setProjectType(ProjectType.controller),
                    title: const Text("Controller"),
                    subtitle: const Text(
                        "Create virtual controller to control your robot"),
                    leading: const Icon(Icons.gamepad),
                    selected: store.projectType == ProjectType.controller,
                    trailing: store.projectType == ProjectType.controller
                        ? const Icon(Icons.check)
                        : null,
                  ),
                  ListTile(
                    onTap: () {
                      store.setProjectType(ProjectType.codde_pi);
                      store.selectHostStore.refreshHosts(context);
                    },
                    title: const Text('Project'),
                    subtitle: const Text(
                        "Configure a CODDE Pi project with your code and specs then deploy it on your robot"),
                    leading: const Icon(Icons.code),
                    selected: store.projectType == ProjectType.codde_pi,
                    trailing: store.projectType == ProjectType.codde_pi
                        ? const Icon(Icons.check)
                        : null,
                  )
                ],
              ),
              if (store.projectType == ProjectType.codde_pi) ...[
                const SizedBox(height: widgetGutter),
                const Text(
                    "Select host for your project (if your robot support SFTP)"),
                if (!store.hostLater) ...[
                  const SizedBox(height: widgetGutter),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () => store.createProject(context,
                              title: projNameController.text),
                          child: const Text('Later'),
                        ),
                        ElevatedButton(
                            onPressed: () async => store.selectHostStore
                                    .selectedHost = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewHostDialog()),
                                ).whenComplete(() => store.selectHostStore
                                    .refreshHosts(context)),
                            child: const Text('New Host')),
                      ]),
                  const SizedBox(height: widgetGutter),
                  ...store.selectHostStore.hosts.toList()
                  //TODO: path field
                ]
              ],
              Center(
                child: ElevatedButton(
                    onPressed: store.validable
                        ? () {
                            if (store.validate()) {
                              store.createProject(context,
                                  title: projNameController.text);
                            }
                          }
                        : null,
                    child: const Text('CREATE')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
