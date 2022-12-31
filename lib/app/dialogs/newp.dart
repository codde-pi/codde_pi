import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';


import '../../services/db/objects.dart';

class NewP extends HookWidget {
  final Type object;

  NewP(this.object, {super.key});

  final GlobalKey<FormState> _key = GlobalKey();
  final repos = Hive.box<Repo>('projects');
  final devices = Hive.box<Device>('projects');

  final cRepo = useState(0);
  final cDevice = useState(0);

  List<ListTile> listRepos() {  // TODO: listen to chanes ?
    return repos.values.map((e) => ListTile(
      title: Text(e.device.name),
      subtitle: Text('${e.device.sshDevice?.ip ?? 'local'} => ${e.path}'),
      leading: const Icon(Icons.storage_outlined),  // Remote VS local
      trailing: Radio(
        value: e.key,
        groupValue: cRepo,
        onChanged: (value) {
          print("my key $value");
          cRepo.value = value;
        },
      ),
    ),).toList();
  }

  List<ListTile> listDevices() {  // TODO: listen to changes ?
    return devices.values.map((e) => ListTile(
      title: Text(e.name),
      subtitle: Text('${e.sshDevice?.ip}:${e.sshDevice?.port}'),
      leading: const Icon(Icons.hardware_outlined),  // Remote VS local
      trailing: Radio(
        value: e.key,
        groupValue: cRepo,
        onChanged: (value) {
          print("my key $value");
          cDevice.value = value;
        },
      ),
    ),).toList();
  }

  Widget getForm() {
    switch (object) {
      case Project:
        return projectForm();
      case Repo:
        return repoForm();
      case Device:
        return deviceForm();
      default:
        return const Center(child: Text('Unknown form type'));
    }
  }

  Widget projectForm() {
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.disabled,
      child: ListView(
        children: <Widget>[
          TextFormField(), // name
          ListTile(
            title: const Text('Select repository'),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () { /* TODO: go to new Repo Form */ },
            ),
          ),
          ListView(
            children: listRepos(),
          ),
          TextFormField(decoration: const InputDecoration(label: Text("Description")),), // description
          ListTile(
            title: const Text('Select repository'),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () { /* TODO: go to new Device Form */ },
            ),
          ),
          ListView(
            children: listDevices(),
          ),
        ],
      ),
    );
  }

  Widget repoForm() {
    return const Text("");
  }

  Widget deviceForm() {
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return object == Project ? projectForm() : repoForm();
  }
}
