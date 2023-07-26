// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayControllerStore on _PlayControllerStore, Store {
  late final _$scaffoldKeyAtom =
      Atom(name: '_PlayControllerStore.scaffoldKey', context: context);

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

  late final _$_PlayControllerStoreActionController =
      ActionController(name: '_PlayControllerStore', context: context);

  @override
  void toggleEndDrawer() {
    final _$actionInfo = _$_PlayControllerStoreActionController.startAction(
        name: '_PlayControllerStore.toggleEndDrawer');
    try {
      return super.toggleEndDrawer();
    } finally {
      _$_PlayControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openEndDrawer() {
    final _$actionInfo = _$_PlayControllerStoreActionController.startAction(
        name: '_PlayControllerStore.openEndDrawer');
    try {
      return super.openEndDrawer();
    } finally {
      _$_PlayControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scaffoldKey: ${scaffoldKey}
    ''';
  }
}
