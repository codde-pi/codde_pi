import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class TargetDeviceStep extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TargetDeviceStepState();
}

class TargetDeviceStepState extends State<TargetDeviceStep> {
  TargetDeviceStepState();

  bool openNewDeviceForm = false;
  Device? selectedHost;

  void createDevice(Device device) {
    Hive.box<Device>('devices').add(device);
    openForm(false);
  }

  void openForm(bool value) {
    setState(() {
      openNewDeviceForm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceList = Hive.box<Device>('devices').values.toList();
    final userChoices = context
        .select<ProjectLauncherCubit, Project>((cubit) => cubit.state.data!);
    if (userChoices.host != null) {
      selectedHost = userChoices.host!.toDevice();
    }
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () => openForm(true), child: const Text('New Device')),
        if (openNewDeviceForm)
          ControlledDeviceForm(
              validate: createDevice, cancel: () => openForm(false)),
        if (selectedHost != null)
          ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: cddTheme.highlightColor, width: 2.0),
                borderRadius: BorderRadius.circular(5),
              ),
              leading: const Icon(Icons.storage),
              title: Text(selectedHost!.name),
              subtitle: Text(selectedHost!.address ?? ''),
              trailing: Text(selectedHost!.protocol
                  .name), // TODO: change protocol by clicking on it. A floating menu will appear
              onTap: () {
                final key = Hive.box<Device>('devices').add(selectedHost!);
                context.read<ProjectLauncherCubit>().feedData(
                    {"controlledDevice": selectedHost},
                    nextPage: true);
                // createProject(userChoices);
              }),
        ...[
          for (var device in deviceList)
            ListTile(
              leading: const Icon(Icons.games_outlined),
              title: Text(device.name),
              subtitle: Text(device.address ?? ''),
              trailing: Text(device.protocol.name),
              onTap: () {
                context
                    .read<ProjectLauncherCubit>()
                    .feedData({"controlledDevice": device}, nextPage: true);
                // createProject(userChoices);
              },
            )
        ],
        OutlinedButton(
            onPressed: () => context
                .read<ProjectLauncherCubit>()
                .nextPage(), // createProject(userChoices),
            child: const Text("LATER"))
      ],
    );
  }
}
