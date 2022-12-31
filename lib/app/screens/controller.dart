import 'dart:isolate';

import 'package:codde_pi/core/components/controller/simple_button.dart';
import 'package:codde_pi/core/components/view.dart';
import 'package:codde_pi/services/controllers/parser.dart';
import 'package:codde_pi/services/editor/highlighter.dart';
import 'package:codde_pi/services/editor/input.dart';
import 'package:codde_pi/services/hooks/editor.dart';
import 'package:codde_pi/services/hooks/socket.dart';
import 'package:codde_pi/services/providers/controller_provider.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:provider/provider.dart' as provider;

class ControllerPage extends ConsumerStatefulWidget {
  String path;

  ControllerPage(this.path, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControllerPage(path);
}

ChangeNotifierProvider<CJsonProvider> cJsonProvider =
    ChangeNotifierProvider<CJsonProvider>((ref) => CJsonProvider());

var cWidgetProvider = Provider.family((ref, name) {
  // TODO: unused
  if (name == CJsonDataName.size) {
    return ref.watch(cJsonProvider).file.mapSize;
  } else if (name == CJsonDataName.widget) {
    return ref.watch(cJsonProvider).file.widgetMap;
  }
  return ref.watch(cJsonProvider).file.data;
});

class _ControllerPage extends ConsumerState<ControllerPage> {
  final String path;
  final controllerProvider =
      StateNotifierProvider<ControllerProvider, ControllerMode>(
          (ref) => ControllerProvider());
  late FutureProvider jsonFile;

  _ControllerPage(this.path);

  @override
  void initState() {
    jsonFile = FutureProvider<CJson>((ref) async {
      return await ref.read(cJsonProvider.notifier).openFile(path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mode = ref.watch(controllerProvider);
    var doc = DocumentProvider();  // TODO; optimize
    return ref.watch(jsonFile).when(
        data: (file) => Stack(
              children: [
                // TODO: brut mode
                if (mode == ControllerMode.run)
                  // TODO: enclose in Scaffold for button `edit mode` and `save`
                  Controller()
                else if (mode == ControllerMode.edition)
                  ControllerEditor()
                else
                  provider.MultiProvider(providers: [
                    provider.FutureProvider(
                        create: (_) => doc.openFile(path),
                        initialData: null),
                    provider.ChangeNotifierProvider(
                        create: (context) => doc),
                    provider.Provider(create: (context) => Highlighter()),
                  ], child: const InputListener(child: View())),
                Positioned(
                  right: 0.0,
                  child: ToggleButtons(
                      selectedColor: Color(Colors.yellow.value),
                      disabledColor: Color(Colors.grey.value),
                      onPressed: (value) {
                        var _mode = ref.read(controllerProvider.notifier);
                        switch (value) {
                          case 0:
                            print('edit mode');
                            _mode.edit();
                            break;
                          case 1:
                            // brut mode
                            _mode.brut();
                            break;
                          case 2:
                            _mode.run();
                            break;
                        }
                      },
                      isSelected: [
                        mode == ControllerMode.edition,
                        mode == ControllerMode.brut,
                        mode == ControllerMode.run
                      ],
                      children: const [
                        Icon(Icons.text_fields),
                        Icon(Icons.chair_alt),
                        Icon(Icons.play_arrow),
                      ]),
                ),
              ],
            ),
        error: (err, stack) => Center(child: Text("$err => $stack")),
        loading: () => const CircularProgressIndicator());
  }
}

class Controller extends HookConsumerWidget {
  final streamSocket = StreamSocket();

  Controller({super.key});

  List<Widget> parseMap(Socket socket, Map<String, dynamic> widgetMap) {
    print("my map $widgetMap");
    if (widgetMap.isNotEmpty) {
      return widgetMap.keys.map<Widget>((key) {
        print('$key to widgetize');
        return fromJsonCtrl(key, widgetMap[key], socket);
      }).toList();
    }
    return [const Text('no widgets')];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socket = useSocketIO(
        uri: 'localhost',
        port: '8080',
        optionBuilder: OptionBuilder().setTransports(['websocket']).build());

    useEffect(() {
      print('try to connect');
      socket.onConnect((_) {
        print('connect');
        socket.emit('my_event', 'test');
      });

      // When an event received from server, data is added to the stream
      socket.on('event', (data) => streamSocket.addResponse);
      socket.on('my_response', (data) => print('response'));
      socket.onDisconnect((_) => print('disconnect'));

      return null; // socket.dispose();
    }, [socket]);

    var cJson = ref.watch(cJsonProvider).file;

    return Stack(
      fit: StackFit.expand,
      children: parseMap(socket, cJson.widgetMap),
    );
  }
}

class ControllerEditor extends ConsumerWidget {
  Color targetColor = Colors.black;

  /*void showSnackBar(String text, int index, {Color color = Colors.grey}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          "$text $index",
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }*/

  List<Widget> parseMap(Map<String, dynamic> widgetMap) {
    // TODO: to update with `ref`
    print("my map $widgetMap");
    if (widgetMap.isNotEmpty) {
      return widgetMap.keys.map<Widget>((key) {
        print('$key to edit');
        return fromJsonEdit(key, widgetMap[key]);
      }).toList();
    }
    return [const Text('no widgets')];
  }

  List<Widget> getMesh(WidgetRef ref, Size? meshSize /*, listWidgets*/) {
    //var meshSize = const Size(1920.0, 1080.0); // WidgetsBinding.instance.window.devicePixelRatio
    if (meshSize == null) {
      return List.generate(
          1, (index) => const Positioned(child: Text("No map size defined")));
    }
    var itemSize = 40.0;
    // TODO: divide width and height by 10, and round value if necessary
    List<Widget> list = List.generate(
        ((meshSize.width ~/ itemSize) * (meshSize.height ~/ itemSize)).toInt(),
/*square
        left: itemSize * (index % (meshSize.width / itemSize)),
        top: (itemSize * (index ~/ (meshSize.height / itemSize))),*/
        (index) => Positioned(
              left: itemSize * (index % (meshSize.width ~/ itemSize)),
              top: (itemSize * (index ~/ (meshSize.width ~/ itemSize))),
              width: itemSize,
              height: itemSize,
              child: DragTarget<String>(
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  if (true) {
                    //showSnackBar('Accepted', index, color: Colors.blue);
                  }
                  targetColor = Colors.transparent;
                  // TODO: create provider to changing color for specific widget only
                  ref.read(cJsonProvider.notifier).update(data, "x",
                      (itemSize * (index % (meshSize.width ~/ itemSize))));
                  ref.read(cJsonProvider.notifier).update(data, "y",
                      (itemSize * (index ~/ (meshSize.width ~/ itemSize))));
                },
                onLeave: (_) {
                  // TODO
                  targetColor = Colors.transparent;
                },
                onMove: (_) {
                  // TODO
                  targetColor = Colors.orange;
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: targetColor, //color of border
                          width: 2, //width of border
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  );
                },
              ),
            ));
    //list.addAll(listWidgets);
    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cJsonFile = ref.watch(cJsonProvider).file;

    // var listCWidgets = ref.watch(cJsonProvider);
    return Stack(
      fit: StackFit.expand,
      children: getMesh(
              ref,
              cJsonFile
                  .mapSize) + /*[
        for (var wgt in listCWidgets.keys) fromJsonEdit(wgt, listCWidgets[wgt])
          ]*/
          parseMap(cJsonFile.widgetMap), // TODO: trop de rebuild. HookWidget ?
    );
  }
}

class A {}
