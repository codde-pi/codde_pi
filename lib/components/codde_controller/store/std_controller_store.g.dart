// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'std_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StdControllerStore on _StdControllerStore, Store {
  late final _$stdinAtom =
      Atom(name: '_StdControllerStore.stdin', context: context);

  @override
  String get stdin {
    _$stdinAtom.reportRead();
    return super.stdin;
  }

  @override
  set stdin(String value) {
    _$stdinAtom.reportWrite(value, super.stdin, () {
      super.stdin = value;
    });
  }

  late final _$stdoutAtom =
      Atom(name: '_StdControllerStore.stdout', context: context);

  @override
  String get stdout {
    _$stdoutAtom.reportRead();
    return super.stdout;
  }

  @override
  set stdout(String value) {
    _$stdoutAtom.reportWrite(value, super.stdout, () {
      super.stdout = value;
    });
  }

  late final _$_StdControllerStoreActionController =
      ActionController(name: '_StdControllerStore', context: context);

  @override
  dynamic addIn(String txt) {
    final _$actionInfo = _$_StdControllerStoreActionController.startAction(
        name: '_StdControllerStore.addIn');
    try {
      return super.addIn(txt);
    } finally {
      _$_StdControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOut(String txt) {
    final _$actionInfo = _$_StdControllerStoreActionController.startAction(
        name: '_StdControllerStore.addOut');
    try {
      return super.addOut(txt);
    } finally {
      _$_StdControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearIn() {
    final _$actionInfo = _$_StdControllerStoreActionController.startAction(
        name: '_StdControllerStore.clearIn');
    try {
      return super.clearIn();
    } finally {
      _$_StdControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearOut() {
    final _$actionInfo = _$_StdControllerStoreActionController.startAction(
        name: '_StdControllerStore.clearOut');
    try {
      return super.clearOut();
    } finally {
      _$_StdControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stdin: ${stdin},
stdout: ${stdout}
    ''';
  }
}
