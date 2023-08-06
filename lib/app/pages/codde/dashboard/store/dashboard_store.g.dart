// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStore, Store {
  late final _$needCoddeReloadAtom =
      Atom(name: '_DashboardStore.needCoddeReload', context: context);

  @override
  bool get needCoddeReload {
    _$needCoddeReloadAtom.reportRead();
    return super.needCoddeReload;
  }

  @override
  set needCoddeReload(bool value) {
    _$needCoddeReloadAtom.reportWrite(value, super.needCoddeReload, () {
      super.needCoddeReload = value;
    });
  }

  late final _$_DashboardStoreActionController =
      ActionController(name: '_DashboardStore', context: context);

  @override
  void askCoddeReload() {
    final _$actionInfo = _$_DashboardStoreActionController.startAction(
        name: '_DashboardStore.askCoddeReload');
    try {
      return super.askCoddeReload();
    } finally {
      _$_DashboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
needCoddeReload: ${needCoddeReload}
    ''';
  }
}
