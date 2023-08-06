// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_controller_map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddControllerMapStore on _AddControllerMapStore, Store {
  late final _$formKeyAtom =
      Atom(name: '_AddControllerMapStore.formKey', context: context);

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

  late final _$_AddControllerMapStoreActionController =
      ActionController(name: '_AddControllerMapStore', context: context);

  @override
  bool validate() {
    final _$actionInfo = _$_AddControllerMapStoreActionController.startAction(
        name: '_AddControllerMapStore.validate');
    try {
      return super.validate();
    } finally {
      _$_AddControllerMapStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey}
    ''';
  }
}
