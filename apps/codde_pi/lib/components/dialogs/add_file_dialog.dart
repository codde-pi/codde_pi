import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum _FileType { file, folder }

class AddFileDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddFileDialogState();
  }
}

class _AddFileDialogState extends State<AddFileDialog> {
  // ValueNotifier<_FileType> fileType = ValueNotifier(_FileType.file);
  _FileType fileType = _FileType.file;
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: widgetGutter / 2,
          ),
          Text("New item", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(
            height: widgetGutter / 2,
          ),
          Divider(
            height: 2.0,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(
            height: widgetGutter / 2,
          ),
          RadioMenuButton(
              value: _FileType.file,
              groupValue: fileType,
              onChanged: (v) => setState(() => fileType = v!),
              child: Text('File')),
          RadioMenuButton(
              value: _FileType.folder,
              groupValue: fileType,
              onChanged: (v) => setState(() => fileType = v!),
              child: Text('Folder')),
          Padding(
            padding: EdgeInsets.only(
                left: widgetGutter / 2, right: widgetGutter / 2),
            child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "File name"),
                validator: (value) => value!.isNotEmpty ? null : "Required",
                controller: nameController),
          ),
          Padding(
            padding: EdgeInsets.all(widgetGutter / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("CANCEL")),
                ElevatedButton(
                    onPressed: () => formKey.currentState!.validate()
                        ? Navigator.of(context).pop(FileEntity(
                            nameController.text, fileType == _FileType.folder))
                        : null,
                    child: const Text("VALIDATE")),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
