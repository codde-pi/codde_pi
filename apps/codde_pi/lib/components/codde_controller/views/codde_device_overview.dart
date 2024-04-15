import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Subpage expanding all informations of a device
/// Assigned to Controller (loaded in parent)
/// On any modifications, this widget have to refresh parent UI
class CoddeDeviceOverview extends StatelessWidget {
  final int? deviceId;
  // TODO: list props ?
  const CoddeDeviceOverview({super.key, required this.deviceId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(widgetGutter / 2),
      child: deviceId == null
          ? const Padding(
              padding: EdgeInsets.all(widgetGutter),
              child: Text('None'),
            )
          : ValueListenableBuilder(
              valueListenable:
                  Hive.box<Device>("devices").listenable(keys: [deviceId]),
              builder: (context, box, widget) {
                final Device? device = box.get(deviceId);
                if (device == null) {
                  return Text("Unknown Device ID: $deviceId");
                }
                return Column(
                  children: [
                    Text(
                      "Target Device",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: widgetGutter / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("ID"), Text(deviceId.toString())],
                    ),
                    const SizedBox(height: widgetGutter / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("NAME"), Text(device.name)],
                    ),
                    const SizedBox(height: widgetGutter / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("PROTOCOL"),
                        Text(device.protocol.name)
                      ],
                    ),
                    const SizedBox(height: widgetGutter / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ADDRESS"),
                        Text(device.address ?? '---')
                      ],
                    ),
                    const SizedBox(height: widgetGutter / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("MODEL"), Text(device.model.name)],
                    ),
                  ],
                );
              }),
    );
  }
}
