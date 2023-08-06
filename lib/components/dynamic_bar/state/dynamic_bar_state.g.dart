// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_bar_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DynamicBarState on _DynamicBarState, Store {
  Computed<ObservableList<DynamicBarDestination>>? _$pagedComputed;

  @override
  ObservableList<DynamicBarDestination> get paged => (_$pagedComputed ??=
          Computed<ObservableList<DynamicBarDestination>>(() => super.paged,
              name: '_DynamicBarState.paged'))
      .value;
  Computed<ObservableList<IconData>>? _$iconsComputed;

  @override
  ObservableList<IconData> get icons =>
      (_$iconsComputed ??= Computed<ObservableList<IconData>>(() => super.icons,
              name: '_DynamicBarState.icons'))
          .value;

  late final _$destinationsAtom =
      Atom(name: '_DynamicBarState.destinations', context: context);

  @override
  ObservableList<DynamicBarDestination> get destinations {
    _$destinationsAtom.reportRead();
    return super.destinations;
  }

  @override
  set destinations(ObservableList<DynamicBarDestination> value) {
    _$destinationsAtom.reportWrite(value, super.destinations, () {
      super.destinations = value;
    });
  }

  late final _$previousDestinationsAtom =
      Atom(name: '_DynamicBarState.previousDestinations', context: context);

  @override
  ObservableList<DynamicBarDestination>? get previousDestinations {
    _$previousDestinationsAtom.reportRead();
    return super.previousDestinations;
  }

  @override
  set previousDestinations(ObservableList<DynamicBarDestination>? value) {
    _$previousDestinationsAtom.reportWrite(value, super.previousDestinations,
        () {
      super.previousDestinations = value;
    });
  }

  late final _$fabAtom = Atom(name: '_DynamicBarState.fab', context: context);

  @override
  DynamicFab? get fab {
    _$fabAtom.reportRead();
    return super.fab;
  }

  @override
  set fab(DynamicFab? value) {
    _$fabAtom.reportWrite(value, super.fab, () {
      super.fab = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_DynamicBarState.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_DynamicBarStateActionController =
      ActionController(name: '_DynamicBarState', context: context);

  @override
  ObservableList<Widget> pages() {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.pages');
    try {
      return super.pages();
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(DynamicBarDestination page) {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.setPage');
    try {
      return super.setPage(page);
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFab(
      {required IconData iconData,
      required Function action,
      IconButton? extended}) {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.setFab');
    try {
      return super
          .setFab(iconData: iconData, action: action, extended: extended);
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic disableFab() {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.disableFab');
    try {
      return super.disableFab();
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFab({int page = 0}) {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.updateFab');
    try {
      return super.updateFab(page: page);
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void defineDestinations(
      BuildContext context, List<DynamicBarDestination> destinations) {
    final _$actionInfo = _$_DynamicBarStateActionController.startAction(
        name: '_DynamicBarState.defineDestinations');
    try {
      return super.defineDestinations(context, destinations);
    } finally {
      _$_DynamicBarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
destinations: ${destinations},
previousDestinations: ${previousDestinations},
fab: ${fab},
currentPage: ${currentPage},
paged: ${paged},
icons: ${icons}
    ''';
  }
}
