import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DeviceDetails extends StatelessWidget {
  Device device;
  DeviceDetails({required this.device});
  final bar = GetIt.I.get<DynamicBarState>();

  @override
  Widget build(BuildContext context) {
    bar.setFab(
        iconData: Icons.network_ping, action: () {/* TODO: ping action */});
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: Column(
        children: [
          // TODO: image of model
          Card(
            child: Row(
              children: [
                const Text('Protocol:'),
                const SizedBox(width: 24.0),
                Text(device.protocol.toString()),
              ],
            ),
          ),
          Card(
            child: Row(
              children: [
                const Text('Address:'),
                Text(device.address ?? ''),
                IconButton(
                    onPressed: () {/* clipboard */},
                    icon: const Icon(Icons.copy))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
