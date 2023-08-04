import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/theme.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';

class WidgetDetailsSheet extends BottomSheet {
  final EditControllerBloc bloc;

  WidgetDetailsSheet({super.key, required this.bloc})
      : super(
            onClosing: () {},
            builder: (context) => Container(color: Colors.red));
  final posX = TextEditingController();
  final posY = TextEditingController();

  ControllerWidget getWidget() {
    return bloc.state.widgets[bloc.state.showDetails]!;
  }

  void udpatePos(BuildContext context, {String? x, String? y}) {
    bloc.add(ControllerWidgetMoved(
        bloc.state.showDetails!,
        x != null ? int.parse(x) : getWidget().x,
        y != null ? int.parse(y) : getWidget().y));
  }

  // FIXME: doesn't work. See: https://github.com/flutter/flutter/issues/27600
  // @override
  // VoidCallback get onClosing =>
  //     () => bloc.add(const ControllerWidgetCanceled());

  @override
  WidgetBuilder get builder => bloc.state.showDetails == 0 ||
          bloc.state.showDetails == null
      ? super.builder
      : (context) {
          final widget = getWidget();
          posX.text = widget.x.toString();
          posY.text = widget.y.toString();
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    /* children: [
                  Text('position `${bloc.state.showDetails}` '),
                  Text(widget.x.toString()),
                  Text(widget.y.toString())
                ], */
                    children: [
                      const Expanded(flex: 3, child: Text('Position')),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: posX,
                          onSubmitted: (value) => udpatePos(context, x: value),
                          onTapOutside: (value) =>
                              udpatePos(context, x: posX.text),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: posY,
                          onSubmitted: (value) => udpatePos(context, y: value),
                          onTapOutside: (value) =>
                              udpatePos(context, y: posY.text),
                        ),
                      )
                    ]),
                const SizedBox(height: widgetGutter),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                        children: [const Text('Name'), Text(widget.nickname!)]),
                    TableRow(children: [
                      const Expanded(flex: 2, child: Text('X')),
                      Text(widget.x.toString()),
                    ]),
                    TableRow(children: [
                      const Expanded(flex: 2, child: Text('Y')),
                      Text(widget.y.toString()),
                    ]),
                    TableRow(children: [
                      const Text('Data'),
                      Text(controllerWidgetDef.values
                          .firstWhere(
                              (element) => element.class_ == widget.class_)
                          .commitFrequency
                          .name)
                    ]),
                    /* TableRow(
                        children:
                            const ControllerApiAttribute(valueType: 'null')
                                .toJson()
                                .keys
                                .map<Text>((e) => Text(e))
                                .toList()),
                    ...controllerWidgetDef.values
                        .firstWhere(
                            (element) => element.class_ == widget.class_)
                        .api
                        .map((e) => TableRow(
                            children: e
                                .toJson()
                                .values
                                .map<Text>((value) => Text(value))
                                .toList()))
                        .toList(), */
                  ],
                ),
                const SizedBox(height: widgetGutter),
                FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                      bloc.add(ControllerWidgetRemoved(widget.id));
                    },
                    label: const Text('DELETE'),
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
        };

  /* return Table(
      children: [
        TableRow(children: [const Text('Name'), Text(widget.name!)]),
        TableRow(children: [
          const Expanded(flex: 2, child: Text('Position')),
          Text(widget.x.toString()),
          const SizedBox(width: 24.0),
          Text(widget.y.toString()),
        ]),
        TableRow(children: [
          const Text('Data'),
          Text(controllerWidgetDef.values
              .singleWhere((element) => element.name == widget.name)
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
            .singleWhere((element) => element.name == widget.name)
            .api
            .map((e) => TableRow(
                children: e
                    .toJson()
                    .values
                    .map<Text>((value) => Text(value))
                    .toList()))
            .toList(),
              ],
    ); */
}

final widgetNotFoundBuidler = (context) => Container(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: Text('No widget found')),
    );
