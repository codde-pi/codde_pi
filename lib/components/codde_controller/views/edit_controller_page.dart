import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/add_widget/add_widget_dialog.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/dialogs/controller_properties_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/components/sheets/widget_details_sheet.dart';
import 'package:codde_pi/main.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EditControllerPage extends DynamicBarWidget {
  final String path;
  EditControllerPage({
    super.key,
    required this.path,
  });
  late final widgetRepo = ControllerWidgetRepository(
      ControllerWidgetApi(map: ControllerMap(path: path)));

  ValueNotifier<EditControllerView?> _view = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    _view.value = EditControllerView(path: path);
    return BlocProvider(
        create: (context) => EditControllerBloc(repo: widgetRepo)
          ..add(ControllerMapSubscribed())
          ..add(ControllerWidgetSubscribed()),
        lazy: false,
        child: _view.value);
  }

  @override
  setFab(BuildContext context) {
    _view.addListener(() {
      _view.value?.setFab(context);
    });
  }
}

class EditControllerView extends DynamicBarWidget {
  final String path;
  EditControllerView({super.key, required this.path});
  final store = EditControllerStore();
  EditControllerBloc? bloc;

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
    super.build(context);
    final coddeStore = Provider.of<CoddeControllerStore>(context);
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
            onPressed: () => coddeStore.playMode(),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<EditControllerBloc>().add(ControllerMapSaved());
                  coddeStore.playMode();
                },
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () => store.openEndDrawer(),
                icon: const Icon(Icons.menu)),
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
      ),
    );
  }

  @override
  setFab(BuildContext context) {
    bar.setFab(
      iconData: Icons.add,
      action: () async => addWidget(context),
      extended: IconButton(
          onPressed: () {/* TODO: set play mode but warning dialog before */},
          icon: const Icon(Icons.delete)),
    );
  }
}
