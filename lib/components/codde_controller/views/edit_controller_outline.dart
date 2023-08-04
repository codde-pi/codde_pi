import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditControllerOutline extends StatelessWidget {
  const EditControllerOutline({super.key});
  // TODO: create Tree

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
          initialData: const <int, ControllerWidget>{},
          stream: context.read<EditControllerBloc>().repo.streamWidgets(),
          builder:
              (context, AsyncSnapshot<Map<int, ControllerWidget>> snapshot) =>
                  snapshot.data != null
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final key = snapshot.data!.keys.toList()[index];
                            return ListTile(
                              title: Text(snapshot.data![key]!.name),
                              subtitle: Text(
                                  "position: (${snapshot.data![key]!.x}, ${snapshot.data![key]!.y})"),
                            );
                          })
                      : const Center(child: Text('No active widget found'))),
    );
  }
}
