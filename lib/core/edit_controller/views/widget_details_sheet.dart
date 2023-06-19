import 'package:codde_pi/core/edit_controller/bloc/edit_controller_bloc.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetDetailsSheet extends StatelessWidget {
  final posX = TextEditingController();
  final posY = TextEditingController();

  ControllerWidget getWidget(EditControllerBloc bloc) {
    return bloc.state.widgets[bloc.state.showDetails]!;
  }

  void udpatePos(BuildContext context, {String? x, String? y}) {
    final b = context.read<EditControllerBloc>();
    b.add(ControllerWidgetMoved(
        b.state.showDetails!,
        x != null ? int.parse(x) : getWidget(b).x,
        y != null ? int.parse(y) : getWidget(b).y));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EditControllerBloc>();
    posX.text = getWidget(bloc).x.toString();
    posY.text = getWidget(bloc).y.toString();
    return Table(
      children: [
        TableRow(children: [Text('Name'), Text(getWidget(bloc).name!)]),
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
              .singleWhere((element) => element.name == getWidget(bloc).name)
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
            .singleWhere((element) => element.name == getWidget(bloc).name)
            .api
            .map((e) => TableRow(
                children: e
                    .toJson()
                    .values
                    .map<Text>((value) => Text(value))
                    .toList()))
            .toList()
      ],
    );
  }
}
