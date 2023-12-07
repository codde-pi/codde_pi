import 'dart:io';

import 'package:codde_backend/codde_backend.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path/path.dart';

import 'store/add_controller_map_store.dart';

class AddControllerMapDialog extends AlertDialog {
  final BuildContext context;
  String path;
  AddControllerMapDialog(
      {required this.context, required this.path, super.key});
  final nameController = TextEditingController();
  final store = AddControllerMapStore();
  @override
  Widget? get title => Text("New Controller Map");

  @override
  Widget? get content => Observer(
        builder: (_) => Form(
          key: store.formKey,
          child: TextFormField(
            decoration: InputDecoration(hintText: "Name"),
            controller: nameController,
            onChanged: (_) => store.hideFileExistsError(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Give a name to this controller';
              } else if (store.fileExistsErr != null &&
                  store.fileExistsErr!.isNotEmpty) {
                return store.fileExistsErr;
              }
              return null;
            },
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('CANCEL')),
        ElevatedButton(
            onPressed: () {
              if (store.validate()) createControllerMap();
            },
            child: Text('CREATE'))
      ];

  // TODO: use  `utils.createControllerMap` instead
  void createControllerMap() async {
    print('PATH = ${join(path, nameController.text)}');
    final map = ControllerMap.create(
        context: context, path: join(path, nameController.text.trim()));
    final api = ControllerWidgetApi(map: map);
    FileEntity? file;
    try {
      file = await api.createMap();
    } catch (e) {
      /* if (e is SftpStatusError || e is FileSystemException) {
        print('raise error $e');
        return store.raiseFileExistsError();
      } */
      print('raise error $e');
      store.raiseFileExistsError(e.toString());
      store.validate();
      return;
    }
    Navigator.of(context).pop(file);
  }
}
