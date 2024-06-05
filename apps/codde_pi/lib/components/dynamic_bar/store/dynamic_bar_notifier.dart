import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';

class DynamicSectionNotifier extends ChangeNotifier {
  DynamicSectionNotifier(this._destinations);

  // ============================ SECTIONS ============================
  List<DynamicBarDestination> _destinations;
  DynamicBarDestination? _tmpDestination;

  int _selectedSection = 0;
  bool isCurrentSection(DynamicBarDestination e) => _tmpDestination != null
      ? _tmpDestination!.name == e.name
      : _destinations[_selectedSection] == e;

  int get currentSection => _selectedSection;

  List<DynamicBarDestination> get destinations => _destinations;

  void setSectionList(List<DynamicBarDestination> sections) {
    _destinations = sections;
    notifyListeners();
  }

  void selectSection(int index, [DynamicBarDestination? section]) {
    print('selecting $section');
    _selectedSection = index;
    _tmpDestination = section;
    notifyListeners();
  }
}

// ============================ MENU LIST ============================
class DynamicMenuNotifier extends ChangeNotifier {
  List<DynamicBarMenuItem>? _bottomMenuList;
  int _selectedMenuItem = 0;
  bool Function(BuildContext, int)? _indexer;

  List<DynamicBarMenuItem>? get menu => _bottomMenuList;

  static List<Widget>? menuPages(List<DynamicBarMenuItem>? list) => list
      ?.map((e) => e.widget)
      .where((e) => e != null)
      .toList()
      .cast<Widget>();

  int get currentMenuItem => _selectedMenuItem;

  void selectMenuItem(BuildContext context, int index) {
    bool res = false;
    if (_indexer != null) {
      res = _indexer!(context, index);
    }
    if (!res) _selectedMenuItem = index;
    notifyListeners();
  }

  void overrideIndexer(bool Function(BuildContext, int) indexer) {
    _indexer = indexer;
    notifyListeners();
  }

  int get getLastMenuIndex => _bottomMenuList!.length - 1;

  void setMenuList(
      {required List<DynamicBarMenuItem>? menuList,
      required bool Function(BuildContext, int)? indexer,
      int index = 0}) {
    _bottomMenuList = menuList;
    _selectedMenuItem = index;
    _indexer = indexer;
    notifyListeners();
  }

  void resetMenuList() {
    _bottomMenuList = null;
    _selectedMenuItem = 0;
    _indexer = null;
    notifyListeners();
  }
}

// ================================= FAB ==================================
class DynamicFabNotifier extends ChangeNotifier {
  DynamicFab? _fab;

  DynamicFab? get fab => _fab;

  void setFab(
      {required IconData iconData,
      required Function action,
      IconButton? extended}) {
    _fab = DynamicFab(
      iconData: iconData,
      action: action,
      extended: extended,
    );
    notifyListeners();
  }

  void setFromFab(DynamicFab? fab) {
    _fab = fab;
    notifyListeners();
  }

  disableFab() {
    _fab = null;
    notifyListeners();
  }
}

// ================================= BREADCRUMB ==============================
class DynamicBreadNotifier extends ChangeNotifier {
  final List<Widget> _steps;
  DynamicBreadNotifier(this._steps);

  int _selectedStep = 0;

  int get currentStep => _selectedStep;

  List<Widget> get steps => _steps;

  void selectStep(int index) {
    _selectedStep = index;
    if (_selectedStep < steps.length - 1) {
      _steps.removeRange(index + 1, _steps.length);
    }
    notifyListeners();
  }

  void addStep(Widget step) {
    _steps.add(step);
    notifyListeners();
  }

  void removeLastStep() {
    _steps.removeLast();
    notifyListeners();
  }

  void moveForward() {
    if (currentStep < steps.length - 1) {
      _selectedStep = currentStep + 1;
    } else {
      throw DynamicStateException("Can't go forward on last step");
    }
    notifyListeners();
  }
}

class DynamicStateException implements Exception {
  final String message;
  DynamicStateException(this.message);
}
