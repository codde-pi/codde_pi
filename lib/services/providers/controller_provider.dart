import 'package:codde_pi/services/controllers/parser.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

enum ControllerMode {
  brut,
  edition,
  run
}
class ControllerProvider extends StateNotifier<ControllerMode> {
  ControllerProvider(): super(ControllerMode.run);

  get isEditing => state == ControllerMode.edition;

  void edit() {
    state = ControllerMode.edition;
  }

  void brut() {
    state = ControllerMode.brut;
  }

  void run() {
    state = ControllerMode.run;
  }

 /* void toggleBrut() {
    state
  }*/

  /*void toggleEdit() {
    isEditing = !isEditing;
  }*/
}

class CJsonProvider extends ChangeNotifier {
  CJson file = CJson();

  CJsonProvider();

  Future<CJson> openFile(String path) async {
    await file.openJson(path);
    return file;
  }

  void setMap(map) {
    file.widgetMap = map;
    notifyListeners();
  }

  void update(key, subkey, value) {
    file.widgetMap.update(key, (actual) {
      var state = actual;
      state[subkey] = value; // Actual position centered
      return state;
    });
    notifyListeners();
  }
}

/*class CWidget {
  final int hash;
  CWidget(this.hash);
  Size? size;
  double? x;
  double? y;
}*/
/*
class CWidgetProvider {
  CWidgetProvider(this.cWidget);
  final CWidget cWidget;
}*/
class CWidgetProvider extends StateNotifier<Map<String, dynamic>> {
  CWidgetProvider(super.state);

  void setMap(map) {
    state = map;
  }

  void update(key, subkey, value) {
    state.update(key, (actual) {
      var state = actual;
      state[subkey] = value; // Actual position centered
      return state;
    });
  }
}
