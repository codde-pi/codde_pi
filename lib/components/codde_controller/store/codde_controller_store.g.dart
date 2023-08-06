// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codde_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoddeControllerStore on _CoddeControllerStore, Store {
  late final _$modeAtom =
      Atom(name: '_CoddeControllerStore.mode', context: context);

  @override
  ControllerWidgetMode get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(ControllerWidgetMode value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  late final _$executableAtom =
      Atom(name: '_CoddeControllerStore.executable', context: context);

  @override
  String? get executable {
    _$executableAtom.reportRead();
    return super.executable;
  }

  @override
  set executable(String? value) {
    _$executableAtom.reportWrite(value, super.executable, () {
      super.executable = value;
    });
  }

  late final _$reloadAtom =
      Atom(name: '_CoddeControllerStore.reload', context: context);

  @override
  bool get reload {
    _$reloadAtom.reportRead();
    return super.reload;
  }

  @override
  set reload(bool value) {
    _$reloadAtom.reportWrite(value, super.reload, () {
      super.reload = value;
    });
  }

  late final _$_CoddeControllerStoreActionController =
      ActionController(name: '_CoddeControllerStore', context: context);

  @override
  void editMode() {
    final _$actionInfo = _$_CoddeControllerStoreActionController.startAction(
        name: '_CoddeControllerStore.editMode');
    try {
      return super.editMode();
    } finally {
      _$_CoddeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void playMode() {
    final _$actionInfo = _$_CoddeControllerStoreActionController.startAction(
        name: '_CoddeControllerStore.playMode');
    try {
      return super.playMode();
    } finally {
      _$_CoddeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleMode() {
    final _$actionInfo = _$_CoddeControllerStoreActionController.startAction(
        name: '_CoddeControllerStore.toggleMode');
    try {
      return super.toggleMode();
    } finally {
      _$_CoddeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExecutable({required String deviceUid, required String command}) {
    final _$actionInfo = _$_CoddeControllerStoreActionController.startAction(
        name: '_CoddeControllerStore.setExecutable');
    try {
      return super.setExecutable(deviceUid: deviceUid, command: command);
    } finally {
      _$_CoddeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void askReload() {
    final _$actionInfo = _$_CoddeControllerStoreActionController.startAction(
        name: '_CoddeControllerStore.askReload');
    try {
      return super.askReload();
    } finally {
      _$_CoddeControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mode: ${mode},
executable: ${executable},
reload: ${reload}
    ''';
  }
}
