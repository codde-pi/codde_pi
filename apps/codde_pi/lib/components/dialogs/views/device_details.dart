import 'package:codde_pi/components/codde_controller/views/codde_device_overview.dart';
import 'package:codde_pi/components/utils/host_details.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class DeviceDetails extends StatelessWidget {
  Device device;
  DeviceDetails({required this.device});
  // final bar = GetIt.I.get<DynamicBarState>();

  @override
  Widget build(BuildContext context) {
    // bar.setFab(
    //     iconData: Icons.network_ping, action: () {/* TODO: ping action */});
    return Column(
      children: [
        CoddeDeviceOverview(deviceId: device.key),
        const SizedBox(height: widgetGutter),
        Text('SFTP Hosting', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: widgetGutter),
        HostDetails(host: device.host)
      ],
    );
  }
}
