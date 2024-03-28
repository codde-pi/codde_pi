import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/codde_controller/flame/codde_tiled_component.dart';
import 'package:codde_pi/components/codde_controller/views/codde_device_overview.dart';
import 'package:codde_pi/components/dialogs/add_controlled_device_dialog.dart';
import 'package:codde_pi/components/dialogs/select_device_dialog.dart';
import 'package:codde_pi/components/forms/controlled_device_form.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flame_tiled/flame_tiled.dart' as tiled;

class ControllerProps extends StatefulWidget {
  final String path;
  final Function funRefresh;
  final ControllerProperties props;
  ControllerProps({
    required this.path,
    required this.funRefresh,
    required this.props,
  });
  @override
  State<StatefulWidget> createState() => _ControllerProps();
}

class _ControllerProps extends State<ControllerProps> {
  bool editDeviceMode = false;
  bool editPropsMode = false;
  late final int? deviceId = widget.props.deviceId;
  final deviceOptions = ["change", 'edit', "new"];

  void editDevice(Device device) async {
    await Hive.box<Device>('devices').put(deviceId, device);
    // refresh UI
    setState(() {
      editDeviceMode = false;
    });
  }

  Device? get device => Hive.box<Device>('devices').get(deviceId);

  Future changeDevice(int deviceId) async {
    ControllerProperties newProps = widget.props;
    newProps.byName['deviceId'] = turnDeviceIntoProperty(deviceId);
    await editProps(newProps);
  }

  Future createDevice(Device device) async {
    final int id = await Hive.box<Device>('devices').add(device);
    ControllerProperties newProps = widget.props;
    newProps.byName['deviceId'] = turnDeviceIntoProperty(id);
    await editProps(newProps);
  }

  Future editProps(ControllerProperties props) async {
    final renderableMap = await CoddeTiledComponent.load(
        await getBackend().readSync(widget.path),
        mode: ControllerWidgetMode.dummy);
    renderableMap.tileMap.map.properties = props;
    await ControllerMap(path: widget.path, map: renderableMap.tileMap.map)
        .saveMap();
    // refresh parent UI
    widget.funRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(widgetGutter),
      // TODO: add edit button -> CoddeDeviceDialog(props)
      child: Card(
        color: cddTheme.colorScheme.onPrimary,
        child: Container(
          width: 500.0, //double.infinity,
          height: 500.0,
          child: Padding(
            padding: const EdgeInsets.all(widgetGutter / 2),
            child: Column(
              children: [
                Row(children: [
                  const Text('Target Device'),
                  PopupMenuButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: const Text('Change'),
                        onTap: () async {
                          final deviceId = await showDialog(
                              context: context,
                              builder: (context) => SelectDeviceDialog());
                          await changeDevice(deviceId);
                        },
                      ),
                      if (deviceId != null)
                        PopupMenuItem(
                          child: const Text('Edit'),
                          onTap: () {
                            setState(() {
                              editDeviceMode = true;
                            });
                          },
                        ),
                      /* PopupMenuItem(
                        child: const Text('New'),
                        onTap: () async {
                          final Device? device = await showDialog(
                              context: context,
                              builder: (context) =>
                                  NewControlledDeviceDialog());
                          if (device != null) {
                            await createDevice(device!);
                          }
                        },
                      ), */
                    ],
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Tooltip(
                        showDuration: Duration(seconds: 1),
                        triggerMode: TooltipTriggerMode.tap,
                        message:
                            'Device to be controlled by this controller. If none, a new device should be created.',
                        child: Icon(Icons.help),
                      ),
                    ),
                  ),
                ]),
                editDeviceMode
                    ? ControlledDeviceForm(
                        existingDevice: device,
                        cancel: () => setState(() => editDeviceMode = false),
                        validate: editDevice)
                    : deviceId == null
                        ? Center(
                            child: ElevatedButton(
                                child: const Text('NEW'),
                                onPressed: () async {
                                  final Device? device = await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          NewControlledDeviceDialog());
                                  if (device != null) {
                                    await createDevice(device);
                                  }
                                }),
                          )
                        : CoddeDeviceOverview(
                            deviceId: deviceId,
                          ),
                Row(children: [
                  const Text('Properties'),
                  const Spacer(),
                  IconButton(
                      onPressed: () => setState(() => editPropsMode = true),
                      icon: const Icon(Icons.edit))
                ]),
                editPropsMode
                    ? Expanded(
                        child: _EditProps(
                            props: widget.props,
                            validate: (props) async => await editProps(props),
                            cancel: () =>
                                setState(() => editPropsMode = false)))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: ControllerProperties.defaultController(
                                    widget.props.byName)
                                .length,
                            itemBuilder: (context, index) => CoddeTile(
                                title: Text(
                                    ControllerProperties.defaultController(
                                            widget.props.byName)
                                        .elementAt(index)
                                        .name),
                                subtitle: Text(
                                    '${ControllerProperties.defaultController(widget.props.byName).elementAt(index).value}'),
                                onTap: null)),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Device stuff

// Props stuff
class _EditProps extends StatefulWidget {
  ControllerProperties props;
  final Function cancel;
  final Function validate;
  _EditProps(
      {super.key,
      required this.cancel,
      required this.validate,
      required ControllerProperties props})
      : props = ControllerProperties.defaultController(props.byName);

  @override
  State<StatefulWidget> createState() {
    return _EditablePropsState();
  }
}

class _EditablePropsState extends State<_EditProps> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: widget.props.length,
            itemBuilder: (context, index) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: widgetGutter / 2),
                  Text(widget.props.elementAt(index).name),
                  // Input field for property value
                  // On value change, edit props
                  TextField(
                    controller: TextEditingController(
                        text: widget.props.elementAt(index).value.toString()),
                    onSubmitted: (value) {
                      widget.props.elementAt(index).value = value;
                      setState(() {});
                    },
                  )
                ])),
      ),
      Row(
        children: [
          TextButton(
              onPressed: () => widget.cancel(), child: const Text('CANCEL')),
          ElevatedButton(
              onPressed: () => widget.validate(widget.props),
              child: const Text("VALIDATE"))
        ],
      )
    ]);
  }
}
