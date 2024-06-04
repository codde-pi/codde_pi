import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

import 'toolbar.dart';
import 'toolbar_event.dart';

part 'toolbar_store.g.dart';

class ToolBarStore = _ToolBarStore with _$ToolBarStore;

abstract class _ToolBarStore with Store {
  @observable
  bool ctrlEnabled = false;
  @observable
  bool altEnabled = false;
  @observable
  ToolBarEvent? event;
  @action
  void ctrlKey() {
    ctrlEnabled = !ctrlEnabled;
  }

  @action
  void altKey() {
    altEnabled = !altEnabled;
  }

  @action
  sendEvent(ToolBarEvent event) {
    event = event;
  }
}

class ToolBarNotifier extends ChangeNotifier {
  final ToolBarEnv env;
  ToolBarNotifier({required this.env});
  bool ctrlEnabled = false;
  // bool altEnabled = false;
  ToolBarEvent? _event;

  ToolBarEvent? get event => _event;

  void ctrlKey() {
    ctrlEnabled = !ctrlEnabled;
    notifyListeners();
  }

  /* void altKey() {
    altEnabled = !altEnabled;
    notifyListeners();
  } */

  sendEvent(ToolBarEvent e) {
    _event = e;
    notifyListeners();
  }

  String? handleEvent() {
    String res = '';
    switch (event) {
      case ToolBarEvent.tab:
        res = getTab();
        break;
      case ToolBarEvent.escape:
        res = String.fromCharCode(27);
        break;
      case ToolBarEvent.north:
        res = '\u001B[A'; // Arrow Up key
        break;
      case ToolBarEvent.south:
        res = '\u001B[B'; // Arrow Down key
        break;
      case ToolBarEvent.east:
        res = '\u001B[C'; // Arrow Right key
        break;
      case ToolBarEvent.west:
        res = '\u001B[D'; // Arrow Left key
        break;
      default:
        // TODO: handle the other cases
        return null;
    }
    _event = null;
    // notifyListeners(); // TODO: keep or remove ?
    return res;
  }

  String getTab() {
    switch (env) {
      case ToolBarEnv.terminal:
        return '\t';
      default:
        return '    ';
    }
  }
}
