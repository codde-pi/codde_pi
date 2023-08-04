import 'package:codde_pi/components/project_launcher/utils/project_launcher_utils.dart';
import 'package:codde_pi/components/snackbars/not_implemented_snackbar.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

import 'store/bootstrap_project_store.dart';

class CreateProjectDialog extends SimpleDialog {
  final projNameController = TextEditingController();
  final store = BootstrapProjectStore();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      title: const Text("New Project"),
      children: [
        Form(
          key: store.formKey,
          child: Column(
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
              const Divider(height: 2),
              const SizedBox(height: widgetGutter),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () async {
            if (store.validate()) {
              createProjectFromScratch(projNameController.text).then(
                  (value) => goToProject(context: context, instance: value));
            }
          },
          child: const Text('FROM SCRATCH'),
        ),
        SimpleDialogOption(
          child: const Text('BOOTSTRAP'),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(NotImplementedSnackBar(context));
          }, // TODO: bootstrap dialog with simple options
        ),
        SimpleDialogOption(
          child: const Text('CONFIGURE'),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(NotImplementedSnackBar(context));
          },
        ),
      ],
    );
  }
}
