import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:xterm/xterm.dart';

import 'toolbar.dart';

class ToolBarNotifier extends ChangeNotifier {
  final ToolBarEnv env;
  ToolBarNotifier({required this.env});
  bool ctrlEnabled = false;
  // bool altEnabled = false;
  TerminalKey? _event;

  TerminalKey? get event => _event;

  void ctrlKey() {
    ctrlEnabled = !ctrlEnabled;
    notifyListeners();
  }

  /* void altKey() {
    altEnabled = !altEnabled;
    notifyListeners();
  } */

  sendEvent(TerminalKey e) {
    _event = e;
    notifyListeners();
  }

  TerminalKey? consumeEvent() {
    final event = _event;
    _event = null;
    return event;
  }
}
