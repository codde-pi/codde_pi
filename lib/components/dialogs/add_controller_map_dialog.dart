import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
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
  Widget? get content => Form(
        key: store.formKey,
        child: TextFormField(
          decoration: InputDecoration(hintText: "Name"),
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Give a name to this controller';
            }
            return null;
          },
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

  void createControllerMap() async {
    print('PATH = ${join(path, nameController.text)}');
    final map = ControllerMap.create(
        context: context, path: join(path, nameController.text));
    final api = ControllerWidgetApi(map: map);
    final file = await api.createMap();
    Navigator.of(context).pop(file);
  }
}
