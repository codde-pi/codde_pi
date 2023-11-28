import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:flutter/material.dart';

class ProjectPicker extends StatefulWidget {
  String home;
  ProjectPicker({super.key, this.home = "~"});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Project"),
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(selection),
              child: const Text('VALIDATE')),
        ],
      ),
      body: StreamBuilder(
        stream: backend.listenChildren(selection),
        builder: (context, builder) => ListView.builder(
          itemCount: children.length,
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
        ),
      ),
    );
  }
}
