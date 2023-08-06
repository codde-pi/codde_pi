// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codde_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoddeState on _CoddeState, Store {
  late final _$projectAtom =
      Atom(name: '_CoddeState.project', context: context);

  @override
  Project get project {
    _$projectAtom.reportRead();
    return super.project;
  }

  @override
  set project(Project value) {
    _$projectAtom.reportWrite(value, super.project, () {
      super.project = value;
    });
  }

  late final _$_CoddeStateActionController =
      ActionController(name: '_CoddeState', context: context);

  @override
  void selectHost(Host host) {
    final _$actionInfo = _$_CoddeStateActionController.startAction(
        name: '_CoddeState.selectHost');
    try {
      return super.selectHost(host);
    } finally {
      _$_CoddeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
project: ${project}
    ''';
  }
}
