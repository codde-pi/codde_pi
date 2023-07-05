import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:codde_pi/core/codde_controller/store/codde_controller_store.dart';
import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/edit_controller/flame/edit_controller_flame.dart';
import 'package:codde_pi/core/edit_controller/views/add_widget_dialog.dart';
import 'package:codde_pi/core/edit_controller/views/widget_details_sheet.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
  final GlobalKey<PopupMenuButtonState<int>> _popUpMenuKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final bar = GetIt.I.get<DynamicBarState>();

  void addWidget(BuildContext context) async {
    ControllerWidgetId? res = await showDialog(
        context: context,
        builder: (_) => AddWidgetDialog(),
        barrierDismissible: true);
    if (res != null) {
      final bloc = context.read<EditControllerBloc>();
      final id = bloc.state.map!.nextObjectId!;
      bloc.add(ControllerWidgetAdded(ControllerWidget(
          id: id,
          class_: res.class_,
          name: res.name // TODO: uid instead ?
          ,
          x: 0,
          y: 0)));
    }
  }

  final posX = TextEditingController();
  final posY = TextEditingController();

  ControllerWidget getWidget(EditControllerState state) {
    return state.widgets[state.showDetails]!;
  }

  void udpatePos(BuildContext context, {String? x, String? y}) {
    final b = context.read<EditControllerBloc>();
    b.add(ControllerWidgetMoved(
        b.state.showDetails!,
        x != null ? int.parse(x) : getWidget(b.state).x,
        y != null ? int.parse(y) : getWidget(b.state).y));
  }

  @override
  Widget build(BuildContext context) {
    bar.setFab(iconData: Icons.add, action: () => addWidget(context));
    final coddeStore = Provider.of<CoddeControllerStore>(context);
    final bloc = context.read<EditControllerBloc>();
    return BlocListener<EditControllerBloc, EditControllerState>(
      listener: (context, state) => showModalBottomSheet<void>(
          isDismissible: true,
          context: context,
          builder: (BuildContext context) => WidgetDetailsSheet()),
      listenWhen: (previous, current) => current.showDetails != null,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<EditControllerBloc>().add(ControllerMapSaved());
                  coddeStore.playMode();
                },
                icon: const Icon(Icons.save)),
            PopupMenuButton(
              key: _popUpMenuKey,
              itemBuilder: (_) => <PopupMenuItem>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Open outline'),
                  onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                ),
              ],
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _popUpMenuKey.currentState?.showButtonMenu(),
              ),
            )
          ],
          title: Text(path.split('/').last),
        ),
        endDrawer: ControllerOutline(),
        body: BlocBuilder<EditControllerBloc, EditControllerState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.widgets.length != current.widgets.length,
          builder: (context, state) => GameWidget(
            game: EditControllerFlame(bloc),
          ),
        ),
      ),
    );
  }
}

class ControllerOutline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: const <int, ControllerWidget>{},
        stream: context.read<EditControllerBloc>().repo.streamWidgets(),
        builder:
            (context, AsyncSnapshot<Map<int, ControllerWidget>> snapshot) =>
                snapshot.data != null
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(snapshot.data![index]!.name!),
                              subtitle: Text(
                                  "(${snapshot.data![index]!.x}, ${snapshot.data![index]!.y})"),
                            ))
                    : const Center(child: Text('No active widget found')));
  }
}
