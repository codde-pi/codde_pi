import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FilePickerDialog extends StatefulWidget {
  PickMode pickMode;
  CoddeBackend backend;
  String workDir;

  FilePickerDialog(
      {super.key,
      required this.backend,
      required this.workDir,
      required this.pickMode});

  @override
  State<StatefulWidget> createState() => _PickFileDialog();
}

class _PickFileDialog extends State<FilePickerDialog> {
  late FileEntity item = FileEntity(widget.workDir, true);
  final selectedFile = ValueNotifier<FileEntity?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(item.name)),
        body: Column(children: [
          Expanded(
            child: FilePicker(
              backend: widget.backend,
              path: item.path,
              onSelect: (item) => (item.isDir)
                  ? setState(() {
                      this.item = item;
                    })
                  : widget.pickMode == PickMode.file
                      ? selectedFile.value = item
                      : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(
                      context,
                      widget.pickMode == PickMode.file
                          ? item.path
                          : dirname(item.path)),
                  child: const Text("validate"))
            ],
          )
        ]));
  }
}

enum PickMode { file, folder }
