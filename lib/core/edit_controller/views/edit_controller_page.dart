import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_controller.dart';
import 'package:codde_pi/core/codde_controller/state/codde_controller_controller.dart';
import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/edit_controller/flame/edit_controller_flame.dart';
import 'package:codde_pi/core/edit_controller/views/add_widget_dialog.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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

  void addWidget(BuildContext context) async {
    ControllerWidgetId? res =
        await Get.dialog(AddWidgetDialog(), barrierDismissible: true);
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
    setFab(iconData: Icons.add, action: () => addWidget(context));
    final bloc = context.read<EditControllerBloc>();
    return BlocListener<EditControllerBloc, EditControllerState>(
      listener: (context, state) => showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        builder: (BuildContext context) => Table(
          children: [
            TableRow(children: [Text('Name'), Text(getWidget(state).name!)]),
            TableRow(children: [
              Expanded(flex: 2, child: Text('Position')),
              TextField(
                controller: posX,
                onSubmitted: (value) => udpatePos(context, x: value),
                onTapOutside: (value) => udpatePos(context, x: posX.text),
              ),
              TextField(
                controller: posY,
                onSubmitted: (value) => udpatePos(context, y: value),
                onTapOutside: (value) => udpatePos(context, y: posY.text),
              )
            ]),
            TableRow(children: [
              const Text('Data'),
              Text(controllerWidgetDef.values
                  .singleWhere(
                      (element) => element.name == getWidget(state).name)
                  .commitFrequency
                  .name)
            ]),
            TableRow(
                children: const ControllerApiAttribute(valueType: 'null')
                    .toJson()
                    .keys
                    .map<Text>((e) => Text(e))
                    .toList()),
            ...controllerWidgetDef.values
                .singleWhere((element) => element.name == getWidget(state).name)
                .api
                .map((e) => TableRow(
                    children: e
                        .toJson()
                        .values
                        .map<Text>((value) => Text(value))
                        .toList()))
                .toList()
          ],
        ),
      ),
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
                  Get.find<CoddeControllerController>().playMode();
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
