import 'package:codde_pi/components/forms/alert_dialog_form.dart';
import 'package:codde_pi/core/codde_file_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path/path.dart' as p;

import 'store/create_file_store.dart';

class CreateFileDialog extends StatelessWidget {
  TextEditingController fileNameController = TextEditingController();
  CreateFileStore store = CreateFileStore();

  CreateFileDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialogForm(
        store: store,
        context: context,
        title: Text("New file"),
        validate: () => Navigator.of(context).pop(fileNameController.text),
        child: Ink(
          padding: const EdgeInsets.all(24.0),
          child: Observer(
            builder: (context) => Column(
              children: [
                Row(
                  children: [
                    const Text('File Types:'),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 2,
                      child: DropdownButton(
                        value: store.fileType,
                        items: const [
                          DropdownMenuItem<CoddeFileType>(
                              value: CoddeFileType.python,
                              child: Text("Python")),
                          DropdownMenuItem<CoddeFileType>(
                              value: CoddeFileType.controller,
                              child: Text("Controller")),
                          DropdownMenuItem<CoddeFileType>(
                              value: CoddeFileType.custom,
                              child: Text("Custom extension")),
                        ],
                        onChanged: (value) => store.fileType = value!,
                        hint: const Text("board"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fileNameController,
                        decoration: const InputDecoration(hintText: "filename"),
                      ),
                    ),
                    if (store.fileType != CoddeFileType.custom)
                      Card(
                          child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(extension!)))
                  ],
                ),
                Row(
                  children: [],
                )
              ],
            ),
          ),
        ),
      );

  String? get extension {
    switch (store.fileType) {
      case CoddeFileType.python:
        return ".py";
      case CoddeFileType.controller:
        return ".tmx";
      default:
        return null;
    }
  }
}
