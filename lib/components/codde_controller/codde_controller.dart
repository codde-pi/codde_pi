import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/codde_widgets/api/widget_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';
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

class CoddeController extends StatelessWidget {
  ValueNotifier<TreeViewController> treeController =
      ValueNotifier(TreeViewController());

  final backend = GetIt.I.get<CoddeBackend>();

  @override
  Widget build(BuildContext context) {
    final coddeProject = Provider.of<CoddeState>(context).project;
    final controller = Provider.of<CoddeControllerStore>(context);

    return FutureBuilder(
        future: backend.listChildren(coddeProject.path),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            treeController.value = TreeViewController(
                children: snapshot.data!
                    .where((element) =>
                        element.isDir || element.path.contains('.tmx'))
                    .map(
                        (e) => Node(key: e.path, label: e.path.split('/').last))
                    .toList());
            for (var child in snapshot.data!) {
              if (!child.isDir && child.path.contains('.tmx')) {
                return Scaffold(
                  drawer: ValueListenableBuilder(
                    valueListenable: treeController,
                    builder: ((context, value, child) =>
                        TreeView(controller: treeController.value)),
                  ),
                  body: Observer(
                    builder: (_) =>
                        controller.mode == ControllerWidgetMode.player
                            ? PlayControllerPage(path: child.path)
                            : EditControllerPage(path: child.path),
                  ),
                );
              }
            }
          }

          return const Center(
              child: Column(children: [
            LinearProgressIndicator(),
            Text('Scanning files...')
          ]));
        });
  }
}
