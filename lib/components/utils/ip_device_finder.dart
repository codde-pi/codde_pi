import 'dart:io';

import 'package:arp_scanner/arp_scanner.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';

/* class IpScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: LanScanner().icmpScan('192.168.0',
                progressCallback: (progress) {
              print('Progress: $progress');
            }),
            builder: ((context, snapshot) => ListView.builder(
                  itemCount: snapshot.data,
                ))));
  }
} */

class IpDeviceLister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

void main() {
  runApp(const MaterialApp(home: IpDeviceFinder()));
}

class IpDeviceFinder extends StatefulWidget {
  const IpDeviceFinder({Key? key}) : super(key: key);

  @override
  State<IpDeviceFinder> createState() => _IpDeviceFinderState();
}

class _IpDeviceFinderState extends State<IpDeviceFinder> {
  /* String _result = ''; */
  final deviceList = ValueNotifier<List>([]);

  /* @override
  void initState() {
    super.initState();
    ArpScanner.onScanning.listen((Device device) {
      setState(() {
        _result =
            "${_result}Mac:${device.mac} ip:${device.ip} hostname:${device.hostname} time:${device.time} vendor:${device.vendor} \n";
      });
    });
    ArpScanner.onScanFinished.listen((List<Device> devices) {
      setState(() {
        _result = "${_result}total: ${devices.length}";
      });
    });
  } */

  void quit() async {
    if (Platform.isAndroid) await ArpScanner.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.scanner_sharp),
          onPressed: () async {
            //scan sub net devices
            await ArpScanner.scan();
            setState(() {});
          }),
      appBar: AppBar(
        leading:
            // action button
            IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => quit(),
        ),
        title: const Text('Find IP device on network...'),
      ),
      body: StreamBuilder(
        stream: Platform.isAndroid
            ? ArpScanner.onScanning
            : LanScanner().icmpScan('192.168.0'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            deviceList.value = deviceList.value..add(snapshot.data!);
          }
          if (deviceList.value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: deviceList.value.length,
            itemBuilder: ((context, index) => ListTile(
                  title: Text(deviceList.value[index].ip ?? 'ip'),
                  subtitle: Text(Platform.isAndroid
                      ? deviceList.value[index].mac
                      : 'unknown mac'),
                  onTap: () =>
                      Navigator.pop(context, deviceList.value[index].ip),
                )),
          );
        },
      ),
    );
  }
}
