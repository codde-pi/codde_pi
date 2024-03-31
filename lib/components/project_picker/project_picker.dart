import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:flutter/material.dart';

class ProjectPicker extends StatefulWidget {
  String home;
  ProjectPicker({super.key, this.home = "/root"});
  @override
  State<StatefulWidget> createState() => _ProjectPicker();
}

class _ProjectPicker extends State<ProjectPicker> {
  late String selection = widget.home;
  List<FileEntity> children = [];
  late CoddeBackend backend = getBackend();

  @override
  void initState() {
    super.initState();
  }

  Future<List<FileEntity>> listChildren(String path) async {
    if (!backend.isOpen) {
      await backend.open();
    }
    List<FileEntity> list = await backend.listChildren(path);
    // list.sort((a, b) => a.path.compareTo(b.path));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Project"),
        leading: IconButton(
            onPressed: () =>
                Navigator.of(context)..pop, // FIXME: stuck on black screen
            icon: const Icon(Icons.close)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(selection),
              child: const Text('VALIDATE')),
        ],
      ),
      body: FutureBuilder(
          future: listChildren(selection),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final FileEntity item = children.elementAt(index);
                  return ListTile(
                    title: item.name,
                    leading: item.isDir
                        ? const Icon(
                            Icons.folder,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.file_open_sharp),
                    onTap: () => item.isDir
                        ? setState(() {
                            selection = item.path;
                          })
                        : null,
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Nothing to show. Please retry later'),
              );
            }
          }),
    );
  }
}
