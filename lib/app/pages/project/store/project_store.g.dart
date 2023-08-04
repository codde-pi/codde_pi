// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectStore on _ProjectStore, Store {
  late final _$recentProjectsAtom =
      Atom(name: '_ProjectStore.recentProjects', context: context);

  @override
  ObservableList<dynamic> get recentProjects {
    _$recentProjectsAtom.reportRead();
    return super.recentProjects;
  }

  @override
  set recentProjects(ObservableList<dynamic> value) {
    _$recentProjectsAtom.reportWrite(value, super.recentProjects, () {
      super.recentProjects = value;
    });
  }

  late final _$recentHostsAtom =
      Atom(name: '_ProjectStore.recentHosts', context: context);

  @override
  ObservableList<dynamic> get recentHosts {
    _$recentHostsAtom.reportRead();
    return super.recentHosts;
  }

  @override
  set recentHosts(ObservableList<dynamic> value) {
    _$recentHostsAtom.reportWrite(value, super.recentHosts, () {
      super.recentHosts = value;
    });
  }

  late final _$showAllHostsAtom =
      Atom(name: '_ProjectStore.showAllHosts', context: context);

  @override
  bool get showAllHosts {
    _$showAllHostsAtom.reportRead();
    return super.showAllHosts;
  }

  @override
  set showAllHosts(bool value) {
    _$showAllHostsAtom.reportWrite(value, super.showAllHosts, () {
      super.showAllHosts = value;
    });
  }

  late final _$showAllProjectsAtom =
      Atom(name: '_ProjectStore.showAllProjects', context: context);

  @override
  bool get showAllProjects {
    _$showAllProjectsAtom.reportRead();
    return super.showAllProjects;
  }

  @override
  set showAllProjects(bool value) {
    _$showAllProjectsAtom.reportWrite(value, super.showAllProjects, () {
      super.showAllProjects = value;
    });
  }

  late final _$_ProjectStoreActionController =
      ActionController(name: '_ProjectStore', context: context);

  @override
  void refreshHosts(BuildContext context) {
    final _$actionInfo = _$_ProjectStoreActionController.startAction(
        name: '_ProjectStore.refreshHosts');
    try {
      return super.refreshHosts(context);
    } finally {
      _$_ProjectStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshProjects(BuildContext context) {
    final _$actionInfo = _$_ProjectStoreActionController.startAction(
        name: '_ProjectStore.refreshProjects');
    try {
      return super.refreshProjects(context);
    } finally {
      _$_ProjectStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recentProjects: ${recentProjects},
recentHosts: ${recentHosts},
showAllHosts: ${showAllHosts},
showAllProjects: ${showAllProjects}
    ''';
  }
}
