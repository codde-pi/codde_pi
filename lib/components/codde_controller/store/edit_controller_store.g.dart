// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditControllerStore on _EditControllerStore, Store {
  late final _$scaffoldKeyAtom =
      Atom(name: '_EditControllerStore.scaffoldKey', context: context);

  @override
  GlobalKey<ScaffoldState> get scaffoldKey {
    _$scaffoldKeyAtom.reportRead();
    return super.scaffoldKey;
  }

  @override
  set scaffoldKey(GlobalKey<ScaffoldState> value) {
    _$scaffoldKeyAtom.reportWrite(value, super.scaffoldKey, () {
      super.scaffoldKey = value;
    });
  }

  late final _$_EditControllerStoreActionController =
      ActionController(name: '_EditControllerStore', context: context);

  @override
  void openEndDrawer() {
    final _$actionInfo = _$_EditControllerStoreActionController.startAction(
        name: '_EditControllerStore.openEndDrawer');
    try {
      return super.openEndDrawer();
    } finally {
      _$_EditControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showButtonMenu() {
    final _$actionInfo = _$_EditControllerStoreActionController.startAction(
        name: '_EditControllerStore.showButtonMenu');
    try {
      return super.showButtonMenu();
    } finally {
      _$_EditControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scaffoldKey: ${scaffoldKey}
    ''';
  }
}
