import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/codde_widgets/api/widget_parser.dart';
import 'package:codde_pi/components/dialogs/add_controller_map_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'store/codde_controller_store.dart';
import 'views/edit_controller_page.dart';
import 'views/play_controller_page.dart';

export 'bloc/edit_controller_bloc.dart';
export 'store/std_controller_store.dart';
export 'store/edit_controller_store.dart';
export 'store/play_controller_store.dart';
export 'store/codde_controller_store.dart';
export 'flame/edit_controller_flame.dart';
export 'views/edit_controller_outline.dart';
export 'views/std_controller_view.dart';
export 'flame/play_controller_game.dart';

class CoddeController extends DynamicBarStatefulWidget {
  CoddeController({super.key});

  @override
  DynamicBarStateWidget createDynamicState() => _CoddeController();
}

class _CoddeController extends DynamicBarStateWidget<CoddeController> {
  ValueNotifier<TreeViewController> treeController =
      ValueNotifier(TreeViewController());

  final backend = GetIt.I.get<CoddeBackend>();
  final ValueNotifier<dynamic> _page = ValueNotifier(null);
  // final playControllerKey = GlobalKey<PlayControllerPageState>();

  @override
  void setFab(BuildContext context) {
    if (_page.value == null) {
      print('$runtimeType wait for fab ${_page.value}');
      /* if (playControllerKey.currentState != null) {
        print('current state !!!');
        playControllerKey.currentState?.setFab(context);
      } else { */
      _page.addListener(() {
        print('double listening ${_page.value != null}');
        _page.value?.setFab(context);
      });
      // }
    } else {
      print('lets go FAB');
      // _page.removeListener(() {});
      _page.value?.setFab(context);
    }
  }

  Widget getPage({required CoddeControllerStore store, required String path}) {
    _page.value = store.mode == ControllerWidgetMode.player
        ? PlayControllerPage(/* key: playControllerKey ,*/ path: path)
        : EditControllerPage(path: path);
    return _page.value!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final store = Provider.of<CoddeControllerStore>(context);
    final coddeProject = /* context
        .watch<CoddeState>()
        .project; // */
        Provider.of<CoddeState>(context).project;
    print(widgetColor);

    print('project path = ${coddeProject.path}');
    return SafeArea(
      child: Scaffold(
        drawer: ValueListenableBuilder(
          valueListenable: treeController,
          builder: ((context, value, child) =>
              TreeView(controller: treeController.value)),
        ),
        body: ReactionBuilder(
          builder: (context) => reaction((_) => store.reload, (result) {
            final messenger = ScaffoldMessenger.of(context);

            messenger.showSnackBar(SnackBar(content: Text('Reloading')));
          }),
          child: FutureBuilder(
              future: backend.listChildren(coddeProject.path),
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  treeController.value = TreeViewController(
                      children: snapshot.data!
                          .where((element) =>
                              element.isDir || element.path.contains('.tmx'))
                          .map((e) => Node(key: e.path, label: e.name))
                          .toList());
                  for (var child in snapshot.data!) {
                    if (!child.isDir && child.name.contains('.tmx')) {
                      return Observer(
                        builder: (_) {
                          final widget =
                              getPage(store: store, path: child.path);
                          (_page.value as DynamicFabSelector).setFab(context);
                          return widget;
                        },
                      );
                    }
                  }
                  // TODO: duplicated !!! create widget
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Map found on this project'),
                      SizedBox(height: widgetGutter),
                      FloatingActionButton.extended(
                        onPressed: () async {
                          FileEntity? file = await showDialog(
                              context: context,
                              builder: (context) => AddControllerMapDialog(
                                  path: coddeProject.path, context: context));
                          if (file != null) {
                            setState(() {}); //store.askReload();
                          }
                        },
                        label: Text('New Map'),
                        icon: Icon(Icons.add),
                      )
                    ],
                  ));
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Map found on this project'),
                      SizedBox(height: widgetGutter),
                      FloatingActionButton.extended(
                        onPressed: () async {
                          FileEntity? file = await showDialog(
                              context: context,
                              builder: (context) => AddControllerMapDialog(
                                  path: coddeProject.path, context: context));
                          if (file != null) {
                            setState(() {}); //store.askReload();
                          }
                        },
                        label: Text('New Map'),
                        icon: Icon(Icons.add),
                      )
                    ],
                  ));
                }
                print("DATA ${snapshot.data}");
                return const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      LinearProgressIndicator(),
                      SizedBox(height: widgetGutter),
                      Text('Scanning files...')
                    ]));
              }),
        ),
      ),
    );
  }
}
