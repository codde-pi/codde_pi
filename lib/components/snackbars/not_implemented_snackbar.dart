import 'package:flutter/material.dart';

import 'done_snackbar.dart';

class NotImplementedSnackBar extends SnackBar {
  final BuildContext context;
  NotImplementedSnackBar(this.context, {super.key})
      : super(content: Container());

  @override
  Widget get content => const Text('Sorry :/ Not available for now');

  @override
  SnackBarAction? get action => SnackBarAction(
      label: 'REQUEST',
      onPressed: () =>
          ScaffoldMessenger.of(context).showSnackBar(const DoneSnackBar()));
}
