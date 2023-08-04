// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolbar_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ToolBarStore on _ToolBarStore, Store {
  late final _$ctrlEnabledAtom =
      Atom(name: '_ToolBarStore.ctrlEnabled', context: context);

  @override
  bool get ctrlEnabled {
    _$ctrlEnabledAtom.reportRead();
    return super.ctrlEnabled;
  }

  @override
  set ctrlEnabled(bool value) {
    _$ctrlEnabledAtom.reportWrite(value, super.ctrlEnabled, () {
      super.ctrlEnabled = value;
    });
  }

  late final _$altEnabledAtom =
      Atom(name: '_ToolBarStore.altEnabled', context: context);

  @override
  bool get altEnabled {
    _$altEnabledAtom.reportRead();
    return super.altEnabled;
  }

  @override
  set altEnabled(bool value) {
    _$altEnabledAtom.reportWrite(value, super.altEnabled, () {
      super.altEnabled = value;
    });
  }

  late final _$eventAtom = Atom(name: '_ToolBarStore.event', context: context);

  @override
  ToolBarEvent? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(ToolBarEvent? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$_ToolBarStoreActionController =
      ActionController(name: '_ToolBarStore', context: context);

  @override
  void ctrlKey() {
    final _$actionInfo = _$_ToolBarStoreActionController.startAction(
        name: '_ToolBarStore.ctrlKey');
    try {
      return super.ctrlKey();
    } finally {
      _$_ToolBarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void altKey() {
    final _$actionInfo = _$_ToolBarStoreActionController.startAction(
        name: '_ToolBarStore.altKey');
    try {
      return super.altKey();
    } finally {
      _$_ToolBarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sendEvent(ToolBarEvent event) {
    final _$actionInfo = _$_ToolBarStoreActionController.startAction(
        name: '_ToolBarStore.sendEvent');
    try {
      return super.sendEvent(event);
    } finally {
      _$_ToolBarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ctrlEnabled: ${ctrlEnabled},
altEnabled: ${altEnabled},
event: ${event}
    ''';
  }
}
