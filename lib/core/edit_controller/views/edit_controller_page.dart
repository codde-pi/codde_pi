import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:codde_pi/core/edit_controller/flame/edit_controller_flame.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditControllerPage extends StatelessWidget {
  final widgetRepo = ControllerWidgetRepository(ControllerWidgetApi());
  final path = 'map.tmx'; // TODO: load project

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditControllerBloc(path: path, repo: widgetRepo)
        ..add(ControllerWidgetSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
          title: Text('Controller Name'), // TODO: path name
        ),
        body: const EditControllerView(),
      ),
    );
  }
}

class EditControllerView extends StatelessWidget {
  const EditControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditControllerBloc>();
    return BlocBuilder<EditControllerBloc, EditControllerState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.widgets.length != current.widgets.length,
      builder: (context, state) => GameWidget(
        game: EditControllerFlame(bloc),
      ),
    );
  }
}
