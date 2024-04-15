import 'package:codde_pi/components/project_launcher/utils/project_launcher_utils.dart';
import 'package:codde_pi/components/snackbars/not_implemented_snackbar.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

import 'store/bootstrap_project_store.dart';

SimpleDialog openProjectDialog(BuildContext context) => SimpleDialog(
      title: Text("Choose location"),
      alignment: Alignment.center,
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, ProjectLocationType.internal),
          child: const Text('Internal storage'),
        ),
        SimpleDialogOption(
          child: const Text('SFTP host'),
          onPressed: () => Navigator.pop(context, ProjectLocationType.ssh),
        ),
        SimpleDialogOption(
          child: const Text('USB plugged device'),
          onPressed: () => Navigator.pop(context, ProjectLocationType.usb),
        ),
      ],
    );

enum ProjectLocationType { internal, ssh, usb }
