import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';

class DynamicBarNotifier extends ChangeNotifier {
  DynamicBarNotifier(this._destinations);

  // ============================ SECTIONS ============================
  List<DynamicBarDestination> _destinations;

  int _selectedSection = 0;

  int get currentSection => _selectedSection;

  List<DynamicBarDestination> get destinations => _destinations;

  void setSectionList(List<DynamicBarDestination> sections) {
    _destinations = sections;
    notifyListeners();
  }

  void selectSection(DynamicBarDestination dest) {
    _selectedSection = dest.index;
    changePage(); // FIXME: do better please
    notifyListeners();
  }

  List<DynamicBarDestination> get indexedDestinations {
    return destinations..sort((a, b) => a.index.compareTo(b.index));
  }

  Widget? getWidget(e) => e?.builtWidget ?? e?.widget();

  List<Widget> get sections =>
      indexedDestinations.map<Widget>((e) => getWidget(e)!).toList();

  // ============================ MENU LIST ============================

  List<DynamicBarMenuItem>? _bottomMenuList;
  int _selectedMenuItem = 0;
  bool Function(BuildContext, int)? _indexer;

  List<DynamicBarMenuItem>? get menu => _bottomMenuList;

  static List<Widget>? menuPages(List<DynamicBarMenuItem> list) => list
      .map((e) => e.destination?.widget())
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

  void setMenuList(
      {required List<DynamicBarMenuItem> menuList,
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

  void changePage() {
    notifyListeners();
  }

  // ================================= FAB ==================================
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
  }

  disableFab() {
    _fab = null;
  }
}
