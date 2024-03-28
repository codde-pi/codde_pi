import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Text;
import 'package:flutter/material.dart' as material;

class WidgetDetailsSheet extends StatefulWidget {
  final ControllerClass class_;
  final Layer widgetLayer;
  const WidgetDetailsSheet(
      {super.key, required this.class_, required this.widgetLayer});
  @override
  State<StatefulWidget> createState() {
    return _WidgetDetailsSheet();
  }
}

class _WidgetDetailsSheet extends State<WidgetDetailsSheet> {
  final Map<String, TextEditingController> controllers = {};

  late CustomProperties widgetProperties = widget.widgetLayer.properties;
  CustomProperties? get defaultProperties => widgetDef.defaultProperties;

  ControllerWidgetDef get widgetDef => controllerWidgetDef[widget.class_]!;

  @override
  void initState() {
    super.initState();
    if (defaultProperties != null) {
      for (var attr in defaultProperties!) {
        controllers[attr.name] = TextEditingController(
            text:
                (widgetProperties.byName[attr.name] ?? attr).value.toString());
      }
    }
  }

  void updateProp(Property defaultProp, String value) {
    setState(() {
      widgetProperties.byName[defaultProp.name] = Property(
          name: defaultProp.name, type: defaultProp.type, value: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (defaultProperties != null)
            ...defaultProperties!
                .map(
                  (e) => Row(
                    children: [
                      Expanded(flex: 3, child: material.Text(e.name)),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: controllers[e.name],
                          onSubmitted: (value) => updateProp(e, value),
                          /* onTapOutside: (value) =>
                            udpatePos(context, x: posX.text), */
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          // TODO: add properties from the commonly allowed properties
          const SizedBox(height: widgetGutter),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                const material.Text('Id'),
                material.Text(widget.widgetLayer.id.toString()),
              ]),
              TableRow(children: [
                const material.Text('Name'),
                material.Text(widget.widgetLayer.name)
              ]),
              TableRow(children: [
                const Expanded(flex: 2, child: material.Text('X')),
                material.Text(widget.widgetLayer.x.toString()),
              ]),
              TableRow(children: [
                const Expanded(flex: 2, child: material.Text('Y')),
                material.Text(widget.widgetLayer.y.toString()),
              ]),
              TableRow(children: [
                const material.Text('Data'),
                material.Text(widgetDef.commitFrequency.name),
              ]),
              const TableRow(children: [material.Text("Properties")]),
              ...widgetProperties
                  .map((e) => TableRow(children: [
                        material.Text(e.name),
                        material.Text(e.value.toString())
                      ]))
                  .toList(), // material.Text(e.name))
            ],

            // TODO: insert well known doc
          ),
          const SizedBox(height: widgetGutter),
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.pop(context, widgetProperties);
              },
              label: const material.Text('REMOVE'),
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}

final widgetNotFoundBuidler = (context) => SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: material.Text('No widget found')),
    );
