// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_launcher_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectLauncherStore on _ProjectLauncherStore, Store {
  late final _$projectTypeAtom =
      Atom(name: '_ProjectLauncherStore.projectType', context: context);

  @override
  ProjectType get projectType {
    _$projectTypeAtom.reportRead();
    return super.projectType;
  }

  @override
  set projectType(ProjectType value) {
    _$projectTypeAtom.reportWrite(value, super.projectType, () {
      super.projectType = value;
    });
  }

  late final _$pathTypeAtom =
      Atom(name: '_ProjectLauncherStore.pathType', context: context);

  @override
  ProjectPathType get pathType {
    _$pathTypeAtom.reportRead();
    return super.pathType;
  }

  @override
  set pathType(ProjectPathType value) {
    _$pathTypeAtom.reportWrite(value, super.pathType, () {
      super.pathType = value;
    });
  }

  late final _$selectedHostAtom =
      Atom(name: '_ProjectLauncherStore.selectedHost', context: context);

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

  late final _$_ProjectLauncherStoreActionController =
      ActionController(name: '_ProjectLauncherStore', context: context);

  @override
  dynamic setProjectType() {
    final _$actionInfo = _$_ProjectLauncherStoreActionController.startAction(
        name: '_ProjectLauncherStore.setProjectType');
    try {
      return super.setProjectType();
    } finally {
      _$_ProjectLauncherStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
projectType: ${projectType},
pathType: ${pathType},
selectedHost: ${selectedHost}
    ''';
  }
}
