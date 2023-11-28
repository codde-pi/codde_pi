import 'package:codde_pi/components/dialogs/new_host_dialog.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'store/select_host_store.dart';

class SelectHostDialog extends Dialog {
  final store = SelectHostStore();
  Project? project;

  SelectHostDialog({this.project, super.key});

  void checkConnection() async {
    if (store.selectedHost == null) {
      store.raiseNoHostError();
      return;
    }
    if (await Ping(store.selectedHost!.addr).stream.first.then((value) {
      print(value.response);
      return value.response != null && value.response!.ip != null;
    })) store.hostNowConnected();
  }

  @override
  Widget build(BuildContext context) {
    store.refreshHosts(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Host'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                if (store.selectedHost != null) {
                  String? path;
                  if (project != null) {
                    path =
                        await createHostDir(store.selectedHost!, project!.name);
                  }
                  Navigator.of(context).pop(path != null
                      ? (store.selectedHost, path)
                      : store.selectedHost);
                } else {
                  store.raiseNoHostError();
                }
              },
              child: const Text("VALIDATE"))
        ],
      ),
      body: Observer(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(widgetGutter),
          child: Column(
            children: [
              ...store.hosts.isEmpty
                  ? [
                      Center(
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewHostDialog()),
                                ).whenComplete(
                                    () => store.refreshHosts(context)),
                            child: const Text('New Host')),
                      )
                    ]
                  : store.hosts.toList(),
              if (store.noHostError)
                Text(
                  'Select a host for this project',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                OutlinedButton(
                    onPressed: () async => checkConnection(),
                    child: const Text('CHECK CONNECTION')),
                store.hostConnected
                    ? const Icon(Icons.check)
                    : const Icon(Icons.error)
              ]),
            ],
          ),
        ),
      ),
    );
  }
}