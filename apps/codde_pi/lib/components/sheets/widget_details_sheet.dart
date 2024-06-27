import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/add_widget/widget_api.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Text;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WidgetDetailsSheet extends StatefulWidget {
  final ControllerClass class_;
  final int id;
  final CustomProperties? properties;
  final Function funDelete;
  const WidgetDetailsSheet(
      {super.key,
      required this.id,
      required this.class_,
      required this.properties,
      required this.funDelete});
  @override
  State<StatefulWidget> createState() {
    return _WidgetDetailsSheet();
  }
}

class _WidgetDetailsSheet extends State<WidgetDetailsSheet> {
  late ControllerProperties widgetProperties;
  late final WidgetApi _api = WidgetApi(class_: widget.class_, id: widget.id);

  // ControllerWidgetDef get widgetDef => controllerWidgetDef[widget.class_]!;

  @override
  void initState() {
    /* final widgetDef = controllerWidgetDef[widget.class_]!;
    print("widgetDef is $widgetDef");
    print("widgetProperties is ${widget.properties}");
    widgetProperties = ControllerProperties(
        (widgetDef.defaultProperties?.byName ??
            ControllerProperties.defaultWidget().byName)
          ..updateAll(
              (key, value) => value = widget.properties?.byName[key] ?? value));
    if (widgetProperties != null) {
      for (var attr in widgetProperties!) {
        print('attr: ${attr.name}');
        /* controllers[attr.name] = TextEditingController(
            text:
                (widgetProperties.byName[attr.name] ?? attr).value.toString()); */
      }
    } */
    super.initState();
  }

  /* @override
  Widget build(BuildContext context) {
    return material.Text('hello');
  } */
  Future<String> getWidgetDoc(ControllerWidgetDef def) {
    return rootBundle
        .loadString('assets/codde_doc/widgets/${def.class_.name}.md');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(widgetGutter / 2),
          child: Container(
            // color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                Expanded(child: material.Text("${_api.name}_${widget.id}")),
                TextButton(
                    onPressed: () => widget.funDelete(),
                    child: const material.Text('DELETE')),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(widgetProperties),
                    child: const material.Text('SAVE'))
              ],
            ),
          ),
        ),
        Expanded(
            child: Markdown(
          data: _api.getApi(),
          selectable: true,
        )) // TODO: tab_container
      ],
    );
  }
}

final widgetNotFoundBuidler = (BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: material.Text('No widget found')),
    );
