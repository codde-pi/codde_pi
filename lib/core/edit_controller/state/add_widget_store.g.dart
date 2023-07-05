// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_widget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddWidgetStore on _AddWidgetStore, Store {
  Computed<int>? _$pageComputed;

  @override
  int get page => (_$pageComputed ??=
          Computed<int>(() => super.page, name: '_AddWidgetStore.page'))
      .value;

  late final _$widgetAtom =
      Atom(name: '_AddWidgetStore.widget', context: context);

  @override
  ControllerWidgetId? get widget {
    _$widgetAtom.reportRead();
    return super.widget;
  }

  @override
  set widget(ControllerWidgetId? value) {
    _$widgetAtom.reportWrite(value, super.widget, () {
      super.widget = value;
    });
  }

  late final _$_AddWidgetStoreActionController =
      ActionController(name: '_AddWidgetStore', context: context);

  @override
  void selectWidget(ControllerWidgetId? widgetId) {
    final _$actionInfo = _$_AddWidgetStoreActionController.startAction(
        name: '_AddWidgetStore.selectWidget');
    try {
      return super.selectWidget(widgetId);
    } finally {
      _$_AddWidgetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
widget: ${widget},
page: ${page}
    ''';
  }
}
