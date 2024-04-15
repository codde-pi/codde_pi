import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'select_host_store.g.dart';

class SelectHostStore = _SelectHostStore with _$SelectHostStore;

abstract class _SelectHostStore with Store {
  @observable
  ObservableList hosts = ObservableList.of([]);
  @observable
  Host? selectedHost;
  @observable
  bool noHostError = false;
  @observable
  bool noPathError = false;
  @observable
  bool hostConnected = false;
  @action
  void refreshHosts(BuildContext context) {
    hosts = ObservableList.of(
      Hive.box<Host>('hosts').values.map(
            (e) => RadioMenuButton(
              value: e,
              groupValue: selectedHost,
              onChanged: (host) {
                selectedHost = host;
                refreshHosts(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(e.addr)
                ],
              ), /* ListTile(
                title: Text(e.name),
                subtitle: Text(e.addr),
                onTap: () {
                  selectedHost = e;
                  noHostError = false;
                }, // TODO: overview
                onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title: Text('Actions'),
                          children: [
                            // TODO: edit item
                            SimpleDialogOption(
                              child: Text('DELETE'),
                              onPressed: () async => await e
                                  .delete()
                                  .whenComplete(() => Navigator.pop(context)),
                            )
                          ],
                        )),
              ), */
            ),
          ),
    );
  }

  @action
  void raiseNoHostError() {
    noHostError = true;
  }

  @action
  void raiseNoPathError() {
    noPathError = true;
  }

  @action
  void hostNowConnected() {
    hostConnected = true;
  }
}
