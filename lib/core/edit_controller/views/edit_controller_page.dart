import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/edit_controller/flame/edit_controller_flame.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  const EditControllerView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditControllerBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                context.read<EditControllerBloc>().add(ControllerMapSaved());
              },
              icon: const Icon(Icons.save))
        ],
        title: Text(path.split('/').last),
      ),
      body: BlocBuilder<EditControllerBloc, EditControllerState>(
        bloc: bloc,
        buildWhen: (previous, current) =>
            previous.widgets.length != current.widgets.length,
        builder: (context, state) => GameWidget(
          game: EditControllerFlame(bloc),
        ),
      ),
    );
  }
}
