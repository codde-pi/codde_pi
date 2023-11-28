import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/add_widget/add_widget_dialog.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dialogs/codde_device_dialog.dart';
import 'package:codde_pi/components/sheets/widget_details_sheet.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditControllerPage extends StatelessWidget {
  final String path;
  EditControllerPage({
    super.key,
    required this.path,
  });
  late final widgetRepo = ControllerWidgetRepository(
      ControllerWidgetApi(map: ControllerMap(path: path)));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditControllerBloc(repo: widgetRepo)
          ..add(ControllerMapSubscribed())
          ..add(ControllerWidgetSubscribed()),
        lazy: false,
        child: EditControllerView(path: path));
  }
}

class EditControllerView extends StatelessWidget {
  final String path;
  EditControllerView({super.key, required this.path});
  final store = EditControllerStore();
  EditControllerBloc? bloc;
  GlobalKey<PopupMenuButtonState<int>> popUpMenuKey =
      GlobalKey<PopupMenuButtonState<int>>();

  Future<void> addWidget(
    BuildContext context,
    /* EditControllerBloc bloc */
  ) async {
    print('new widget');
    ControllerWidgetDef? res = await showDialog(
      context: context,
      builder: (_) => AddWidgetDialog(),
    );
    // barrierDismissible: true);
    if (res != null) {
      print('$runtimeType bloc ${bloc != null}');
      // final bloc = built.value!.read<EditControllerBloc>();
      if (bloc != null) {
        final id = bloc!.state.map!.nextObjectId!;
        bloc!.add(ControllerWidgetAdded(ControllerWidget(
            id: id,
            class_: res.class_,
            nickname: res.name // TODO: uid instead ?
            ,
            x: 0,
            y: 0)));
      }
    }
  }

  /* void openWidgetDetails(BuildContext context) {
    final _controller =
        Scaffold.of(context).showBottomSheet(AddWidgetSheet().builder);
    _controller.closed
        .whenComplete(() => bloc?.add(const ControllerWidgetCanceled()));
  } */

  @override
  Widget build(BuildContext context) {
    bloc = context.read<EditControllerBloc>();
    return BlocListener<EditControllerBloc, EditControllerState>(
      listener: (context, state) async {
        final controller =
            Scaffold.of(context).showBottomSheet(WidgetDetailsSheet(
          bloc: bloc!,
        ).builder);
        controller.closed
            .whenComplete(() => bloc!.add(const ControllerWidgetCanceled()));
      },
      listenWhen: (previous, current) =>
          current.showDetails != 0 && current.showDetails != null,
      child: Scaffold(
        key: store.scaffoldKey,
        appBar: AppBar(
          leadingWidth: 72,
          leading: TextButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<EditControllerBloc>().add(ControllerMapSaved());
                  Navigator.of(context).pop(path);
                },
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () => store.openEndDrawer(),
                icon: const Icon(Icons.menu)),
            Observer(
              builder: (context) => PopupMenuButton(
                key: popUpMenuKey,
                itemBuilder: (_) => <PopupMenuItem>[
                  PopupMenuItem(
                    value: 0,
                    child: const Text('Controlled device'),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        print(
                            '$runtimeType sharing ${bloc?.state.map?.properties}');
                        final props = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CoddeDeviceDialog(
                                properties: bloc?.state.map?.properties),
                          ),
                        );
                        if (props != null) changeProperties(context, props);
                      });
                    },
                  ),
                ],
              ),
            )
          ],
          title: Text(path.split('/').last),
        ),
        endDrawer: const EditControllerOutline(),
        body: BlocBuilder<EditControllerBloc, EditControllerState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.widgets.length != current.widgets.length,
          builder: (context, state) => GameWidget(
            game: EditControllerFlame(bloc!),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => addWidget(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void changeProperties(
      BuildContext context, ControllerProperties props) async {
    print('PATH = ${path}');
    final map = ControllerMap(path: path, properties: props);
    final api = ControllerWidgetApi(map: map);
    FileEntity? file;
    try {
      file = await api.saveProperties();
    } catch (e) {
      print('raise error $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    } finally {
      // if done, refresh
      // TODO: refresh all UI ?
    }
  }
}
