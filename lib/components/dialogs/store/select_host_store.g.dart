// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_host_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectHostStore on _SelectHostStore, Store {
  late final _$hostsAtom =
      Atom(name: '_SelectHostStore.hosts', context: context);

  @override
  ObservableList<dynamic> get hosts {
    _$hostsAtom.reportRead();
    return super.hosts;
  }

  @override
  set hosts(ObservableList<dynamic> value) {
    _$hostsAtom.reportWrite(value, super.hosts, () {
      super.hosts = value;
    });
  }

  late final _$selectedHostAtom =
      Atom(name: '_SelectHostStore.selectedHost', context: context);

  @override
  Host? get selectedHost {
    _$selectedHostAtom.reportRead();
    return super.selectedHost;
  }

  @override
  set selectedHost(Host? value) {
    _$selectedHostAtom.reportWrite(value, super.selectedHost, () {
      super.selectedHost = value;
    });
  }

  late final _$noHostErrorAtom =
      Atom(name: '_SelectHostStore.noHostError', context: context);

  @override
  bool get noHostError {
    _$noHostErrorAtom.reportRead();
    return super.noHostError;
  }

  @override
  set noHostError(bool value) {
    _$noHostErrorAtom.reportWrite(value, super.noHostError, () {
      super.noHostError = value;
    });
  }

  late final _$noPathErrorAtom =
      Atom(name: '_SelectHostStore.noPathError', context: context);

  @override
  bool get noPathError {
    _$noPathErrorAtom.reportRead();
    return super.noPathError;
  }

  @override
  set noPathError(bool value) {
    _$noPathErrorAtom.reportWrite(value, super.noPathError, () {
      super.noPathError = value;
    });
  }

  late final _$hostConnectedAtom =
      Atom(name: '_SelectHostStore.hostConnected', context: context);

  @override
  bool get hostConnected {
    _$hostConnectedAtom.reportRead();
    return super.hostConnected;
  }

  @override
  set hostConnected(bool value) {
    _$hostConnectedAtom.reportWrite(value, super.hostConnected, () {
      super.hostConnected = value;
    });
  }

  late final _$_SelectHostStoreActionController =
      ActionController(name: '_SelectHostStore', context: context);

  @override
  void refreshHosts(BuildContext context) {
    final _$actionInfo = _$_SelectHostStoreActionController.startAction(
        name: '_SelectHostStore.refreshHosts');
    try {
      return super.refreshHosts(context);
    } finally {
      _$_SelectHostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void raiseNoHostError() {
    final _$actionInfo = _$_SelectHostStoreActionController.startAction(
        name: '_SelectHostStore.raiseNoHostError');
    try {
      return super.raiseNoHostError();
    } finally {
      _$_SelectHostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void raiseNoPathError() {
    final _$actionInfo = _$_SelectHostStoreActionController.startAction(
        name: '_SelectHostStore.raiseNoPathError');
    try {
      return super.raiseNoPathError();
    } finally {
      _$_SelectHostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hostNowConnected() {
    final _$actionInfo = _$_SelectHostStoreActionController.startAction(
        name: '_SelectHostStore.hostNowConnected');
    try {
      return super.hostNowConnected();
    } finally {
      _$_SelectHostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hosts: ${hosts},
selectedHost: ${selectedHost},
noHostError: ${noHostError},
noPathError: ${noPathError},
hostConnected: ${hostConnected}
    ''';
  }
}
