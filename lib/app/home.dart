import 'package:codde_pi/app/pages/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  final int? index;

  const Home({super.key, this.index});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex = widget.index ?? 0;
  var isExtended = false;

  get screenSize => MediaQuery.of(context).size;

  void initState() {
    super.initState();
  }

  Widget buildListContent(index) {
    switch (index) {
      /*case 1:
        return Tools();
      case 2:
        return Boards();
      case 3:
        return Settings();*/
      default:
        return ControllerDraft();
    }
  }

  Widget buildLogo() {
    return SizedBox(
      height: 36.0,
      width: 36.0,
      child: (SvgPicture.asset('assets/dopy_logo.svg')), // TODO
    );
  }

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return screenSize.height > screenSize.width
        ?
        // PORTRAIT MODE
        Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
                ControllerDraft(),
                //Tools(),
                //Boards(),
                // Settings()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).highlightColor,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              selectedLabelStyle: textTheme.caption,
              unselectedLabelStyle: textTheme.caption,
              onTap: (value) {
                // Respond to item press.
                setState(() => _currentIndex = value);
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Projects',
                  icon: Icon(Icons.view_carousel_rounded),
                  activeIcon: Icon(Icons.view_carousel),
                ),
                /*BottomNavigationBarItem(
            label: 'Community',
            icon: Icon(Icons.language_rounded),
          ),*/
                BottomNavigationBarItem(
                  label: 'Documentation',
                  icon: Icon(Icons.article_outlined),
                  activeIcon: Icon(Icons.article_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Tools',
                  icon: Icon(Icons.construction_outlined),
                  activeIcon: Icon(Icons.construction_rounded),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle_rounded),
                  label: 'Settings',
                ), //todo: a remplacer par vrai icône
              ],
            ),
          )
        :
        // LANDSCAPE MODE
        SafeArea(
            child: Scaffold(
              /*floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,*/
              body: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  NavigationRail(
                    /*backgroundColor: Theme.of(context).cardColor,*/
                    leading: GestureDetector(
                      onTap: () => setState(() => isExtended = !isExtended),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 26.0, left: 4.0, right: 4.0),
                          child: /*isExtended
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    buildLogo(),
                SizedBox(width: 16.0,),
                Text('DOPY', style: TextStyle(color: Theme.of(context).highlightColor),),
              ],)
              : */
                              buildLogo()),
                    ),
                    minWidth: 72.0,
                    minExtendedWidth: 250 /*screenSize.width / 4*/,
                    extended: isExtended,
                    labelType: NavigationRailLabelType
                        .none /*isExtended ? NavigationRailLabelType.none : NavigationRailLabelType.selected*/,
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.construction_outlined),
                        selectedIcon: Icon(
                          Icons.construction_rounded,
                        ),
                        label: Text('My Projects'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.cable_outlined),
                        selectedIcon: Icon(
                          Icons.cable_rounded,
                        ),
                        label: Text('Tools'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.article_outlined),
                        selectedIcon: Icon(
                          Icons.article_rounded,
                        ),
                        label: Text('Boards'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.account_circle_rounded),
                        selectedIcon: Icon(
                          Icons.account_circle_rounded,
                        ),
                        label: Text('Settings'),
                      ),
                    ],
                  ),
                  // This is the main content.
                  Expanded(
                    child: buildListContent(_currentIndex),
                  )
                ],
              ),
            ),
          );
  }
}
