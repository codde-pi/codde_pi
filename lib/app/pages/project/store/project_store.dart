import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  @observable
  ObservableList recentProjects = ObservableList.of([]);
  @observable
  ObservableList recentHosts = ObservableList.of([]);
  @observable
  bool showAllHosts = false;
  @observable
  bool showAllProjects = false;
  @action
  void refreshHosts(BuildContext context) {
    recentHosts = ObservableList.of(
      (showAllHosts
              ? Hive.box<Host>('hosts').values
              : Hive.box<Host>('hosts').values.take(6))
          .map(
        (e) => Card(
            child: ListTile(
          title: Text(e.name),
          subtitle: Text(e.addr),
          onTap: null, // TODO: overview
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
        )),
      ),
    );
  }

  @action
  void refreshProjects(BuildContext context) {
    recentProjects = ObservableList.of(
      Hive.box<Project>(projectsBox).values.take(2).map(
            (e) => Card(
                child: ListTile(
              title: Text(e.name),
              subtitle: Text('Last modified: ${e.dateModified}'),
              onTap: () => Navigator.pushNamed(context, '/codde', arguments: e),
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
            )),
          ),
    );
  }
}
