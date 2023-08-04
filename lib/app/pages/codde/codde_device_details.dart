import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/views/device_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoddeDeviceDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coddeStore = Provider.of<CoddeState>(context);
    return coddeStore.project.controlledDevice == null
        ? Center(
            child: FloatingActionButton.extended(
                onPressed: null,
                label: const Text('New device'),
                icon: const Icon(Icons.add)))
        : DeviceDetails(device: coddeStore.project.controlledDevice!);
  }
}
