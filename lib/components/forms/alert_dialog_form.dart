import 'package:codde_pi/components/forms/store/alert_dialog_form_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AlertDialogForm extends AlertDialog {
  final BuildContext context;
  final Function validate;
  final Widget child;
  final Widget? title;
  AlertDialogFormStore store;

  AlertDialogForm(
      {required this.context,
      required this.validate,
      required this.child,
      required this.store,
      this.title,
      super.key});

  @override
  Widget? get content =>
      Observer(builder: (context) => Form(key: store.formKey, child: child));

  @override
  List<Widget>? get actions => [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL')),
        ElevatedButton(
            onPressed: () {
              if (store.validate()) validate();
            },
            child: const Text('VALIDATE'))
      ];
}
