import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/file_picker/file_picker.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

import 'views/code_writer.dart';

class CodeViewer extends StatefulWidget {
  bool readOnly;
  String workDir;
  CoddeBackend backend;
  CodeViewer(
      {Key? key,
      required this.readOnly,
      required this.workDir,
      CoddeBackend? backend})
      : backend = backend ?? getLocalBackend(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeViewer();
}

class _CodeViewer extends State<CodeViewer> {
  late FileEntity item = FileEntity(widget.workDir, true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (item.isDir) {
      return Scaffold(
        appBar: AppBar(
            title: Text(item.name),
            leading: IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () => setState(() {
                      item = FileEntity(dirname(item.path), true);
                    }))),
        body: FilePicker(
          readOnly: widget.readOnly,
          backend: widget.backend,
          path: item.path,
          onSelect: (item) => setState(() {
            this.item = item;
          }),
        ),
      );
    }
    return CodeWriter(
      path: item.path,
      readOnly: widget.readOnly,
      funBack: () => setState(() {
        item = FileEntity(dirname(item.path), true);
      }),
    );
  }
}
