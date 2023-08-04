// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bootstrap_project_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BootstrapProjectStore on _BootstrapProjectStore, Store {
  late final _$formKeyAtom =
      Atom(name: '_BootstrapProjectStore.formKey', context: context);

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$_BootstrapProjectStoreActionController =
      ActionController(name: '_BootstrapProjectStore', context: context);

  @override
  bool validate() {
    final _$actionInfo = _$_BootstrapProjectStoreActionController.startAction(
        name: '_BootstrapProjectStore.validate');
    try {
      return super.validate();
    } finally {
      _$_BootstrapProjectStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey}
    ''';
  }
}
