/* import 'dart:ffi';

import 'package:codde_pi/services/db/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'newp.dart';

class MyP extends StatefulWidget {
  const MyP({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyP();
  }
}

class _MyP extends State<MyP> {
  var files;

  @override
  Widget build(BuildContext context) {
    return MypForm(context);
  }
}

class MypDialog extends StatelessWidget {
  const MypDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: MypForm(context),
      ),
    );
  }
}

class MypForm extends StatelessWidget {
  // TODO: right side panel with info (like Dolphin file manager)
  // TODO: RESPONSIVE !!!
  final BuildContext context;
  final bool isMobile = false;

  const MypForm(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            child: Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    const Text(
                      'Open Project',
                      style: TextStyle(fontSize: 14),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Repositories",
                          ),
                          const SizedBox(width: 16.0),
                          const Expanded(child: Divider()),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("show all"),
                          )
                        ]),
                    const RepoList(),
                    SizedBox(height: 16.0),
                    Expanded(flex: 3, child: ProjectList()),
                    SizedBox(height: 24.0),
                    ButtonBar(
                      children: [
                        TextButton(onPressed: () {}, child: Text("CANCEL"))
                      ],
                    ),
                  ],
                ))));
  }
}

enum MypIcons { repoLocal, repoRemote, projectLocal, projectRemote }

class MypCard extends StatelessWidget {
  final object;
  final bool add;

  const MypCard(this.object, {this.add = false, super.key});

  void deleting() {
    print('deleting');
    object.delete();
  }

  Future<void> showInfo(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: displayInfo(),
              ),
            ),
            // TODO: OK (go back) button
          );
        });
  }

  List<Widget> displayInfo() {
    // TODO: date, repo and other formats
    return object.toMap().keys.map<Widget>(
      (data) {
        return Text.rich(TextSpan(
            text: "$data:",
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: <InlineSpan>[
              TextSpan(
                text: object.toMap()[data].toString(), // TODO: affichage brut
              )
            ]));
      },
    ).toList();
  }

  IconData getIcon() {
    var image;
    if (object.runtimeType == Project) {
      image = (object as Project).repo.device.sshDevice != null
          ? MypIcons.projectRemote
          : MypIcons.projectLocal;
    } else {
      image = (object as Repo).device.sshDevice != null
          ? MypIcons.repoRemote
          : MypIcons.repoLocal;
    }

    switch (image) {
      case MypIcons.projectLocal:
        return Icons.file_copy_outlined;
      case MypIcons.projectRemote:
        return Icons.file_copy_outlined;
      case MypIcons.repoLocal:
        return Icons.storage;
      case MypIcons.repoRemote:
        return Icons.storage; // TODO: add pastille remote
      default:
        return Icons.storage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
            margin: const EdgeInsets.all(8.0),
            child: add
                ? Center(  // TODO: size
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: 200,
                        alignment: Alignment.topRight,
                        child: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),  // TODO: hover, click
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  deleting();
                                  break;
                                case 1:
                                  showInfo(context);
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text("Delete"),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Infos"),
                                  )
                                ]),
                      ),
                      Container(
                          width: 200,
                          height: 150,
                          alignment: Alignment.center,
                          child: Icon(getIcon())),
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(object.name)),
                    ],
                  )));
  }
}

class RepoList extends HookWidget {
  const RepoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('projects').listenable(),
        builder: (context, box, widget) {
          Iterable values = box.values.whereType<Repo>();
          return values.isNotEmpty
              ? Row(
                  children: <Widget>[
                    ...values.map<Widget>(
                      (data) {
                        return MypCard(data);
                      },
                    ).toList(),
                    const MypCard(
                      Repo, add: true,
                    ),
                  ],
                )
              : Center(
                  child: FloatingActionButton.extended(
                      onPressed: () {}, label: const Text("NEW REPO"),
                      icon: const Icon(Icons.add)));
        });
  }
// TODO: `show all` button
}

class ProjectList extends HookWidget {
  var objects = Iterable.generate(0);
  final int short = 1;

  // TODO: get => collasped = show all ou pas

  ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(short);
    // get expanded => count.value >= objects.length;

    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Recently opened",
            ),
            const SizedBox(width: 16.0),
            const Expanded(child: Divider()),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: () {
                if (count.value == objects.length) {
                  count.value = short;
                } else {
                  count.value = objects.length;
                }
              },
              child: const Text("show all"),
            )
          ]),
      ValueListenableBuilder(
        valueListenable: Hive.box('projects').listenable(),
        builder: (context, box, widget) {
          objects = box.values.whereType<Project>();
          objects
              .toList()
              .sort((a, b) => b.dateModified.compareTo(a.dateModified));
          return objects.isNotEmpty
              ? GridView.count(
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: <Widget>[
              ...objects.take(count.value).map<Widget>(
                    (data) {
                  return MypCard(data);
                },
              ).toList(),
              const MypCard(
                Project, add: true,
              ),
            ],
          ) : Center(
                  child: FloatingActionButton.extended(
                      onPressed: () {}, //=> Navigator.push(context, NewP(Project)), // Routes
                      icon: const Icon(Icons.add), label: const Text("NEW PROJECT"),));
        }),
    ],
    );
  }
}

Box useHiveBox(String box) {
  final state = useMemoized(
      () => box == 'projects' ? Hive.box<Project>(box) : Hive.box<Repo>(box));

  return state;
}
 */