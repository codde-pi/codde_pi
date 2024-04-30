import 'dart:io';
import 'dart:typed_data';

import 'package:args/args.dart';
import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

final ASSET_PATH = "../assets/codde_doc/";
final PATH = "codde_doc";
final exitCode = 0;
final navigatorKey = GlobalKey<NavigatorState>();
ScreenshotController screenshotController = ScreenshotController();

void main(List<String> arguments) async {
  final dir = await getApplicationDocumentsDirectory();
  // final dir = Directory(ASSET_PATH);
  if (dir == null) {
    throw Exception("no output dir");
  }
  await Directory(join(dir.path, PATH)).create().then((value) async {
    await Directory(join(value.path, 'widgets')).create();
    await Directory(join(value.path, 'images')).create();
  });
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  /* runApp(
    MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: cddTheme,
        home: DocGen(dir: dir)),
  ); */
  for (final widget in controllerWidgetDef.values) {
    generateDocs(widget, join(dir.path, PATH));
  }
}

void generateDocs(ControllerWidgetDef def, String output) {
  String doc = "";
  void appendDoc(String data) {
    doc += "$data\n";
  }

  void addTitle(String title) {
    appendDoc("$title\n");
  }

  final docOutput = join(output, "widgets", "${def.class_.name}.md");
  final imgOutput = join(output, "images", "${def.class_.name}.png");
  addTitle("# ${def.class_.name}");
  // image
  final component = def.component(
      class_: def.class_,
      id: 0,
      // TODO: size max ?
      position: Vector2(0, 0),
      properties: def.defaultProperties ?? ControllerProperties.empty,
      style: ControllerStyle.material, // TODO: pixel
      text: null);
  screenshotController
      .captureFromWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: GameWidget(
          game: DummyGame(
              component: getComponent(controllerWidgetDef.values.first)),
        ),
      ),
    ),
  )
      .then((Uint8List? image) async {
    if (image != null) {
      final imagePath = await File(imgOutput).create().then((value) async =>
          await value
              .writeAsBytes(image)
              .then((value) => print("IMAGE $value written")));
      // await imagePath.writeAsBytes(image);
    }
  });
  appendDoc("![${def.class_.name}](${p.relative(imgOutput)})\n");

  // description
  addTitle("# Description");

  appendDoc("${def.description}\n");

  // datasheet
  // - commitFrequency
  // - properties
  // - size
  addTitle("## Datasheet");
  doc += createTableMd([
    "Property",
    "Value"
  ], [
    {"Property": "Commitment", "Value": def.commitFrequency.name},
    {"Property": "Size", "Value": component.sizeFactor},
    {
      "Property": "Properties",
      "Value": def.defaultProperties?.toJson()
    }, // TODO: add common properties
  ]);
  doc += "\n\n";

  // API
  // - command
  // - result
  addTitle("## API");
  doc += createTableMd([
    "Property",
    "Value"
  ], [
    {"Property": "Command", "Value": def.command},
    {"Property": "Result", "Value": def.response},
  ]);
  doc += "\n\n";

  // Example
  addTitle("## Examples");
  // TODO: select examples
  appendDoc("[Zumo Robot](https://github.com/codde-pi/codde_example)\n");

  // Resources
  addTitle("## Resources");
  appendDoc(
      "**API:** [${def.class_.name}](https://github.com/codde-pi/codde_protocol/)\n");

  // output
  final file = File(docOutput);
  file.createSync();
  file.writeAsStringSync(doc);
  print('FILE ${docOutput} written !');
}

WidgetComponent getComponent(ControllerWidgetDef def) => def.component(
    class_: def.class_,
    id: 0,
    // TODO: size max ?
    position: Vector2(0, 0),
    properties: def.defaultProperties ?? ControllerProperties.empty,
    style: ControllerStyle.material, // TODO: pixel
    text: null);

class DummyGame extends FlameGame {
  WidgetComponent component;
  DummyGame({required this.component});

  @override
  Future<void> onLoad() async {
    final flameComp =
        FlameCoddeProtocol(protocol: Protocol.webSocket, address: "");
    // add(TextComponent(text: "No linked device found"));
    print('ADD compoenent');
    flameComp.add(component);
    add(flameComp);
  }
}

String createTableMd(List headline, List<Map> data) {
  String table = "| ${headline.map((e) => "**$e**").join(" | ")} |\n";
  table += "| ${headline.map((e) => "-----").join(" | ")} |\n";
  for (final row in data) {
    table += "| ${row.values.join(" | ")} |\n";
  }
  return table;
}

class DocGen extends StatefulWidget {
  Directory dir;
  DocGen({required this.dir});
  @override
  _DocGenState createState() => _DocGenState();
}

class _DocGenState extends State<DocGen> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<(ControllerWidgetDef, WidgetComponent)>(
          initialData: (
            controllerWidgetDef.values.first,
            getComponent(controllerWidgetDef.values.first)
          ),
          stream: looper(),
          builder: (context, snapshot) {
            generateDocs(snapshot.data!.$1, join(widget.dir.path, PATH));
            return Screenshot(
              controller: screenshotController,
              child: GameWidget(
                game: DummyGame(
                    component: getComponent(controllerWidgetDef.values.first)),
              ),
            );
          }),
    );
  }

  WidgetComponent getComponent(ControllerWidgetDef def) => def.component(
      class_: def.class_,
      id: 0,
      // TODO: size max ?
      position: Vector2(0, 0),
      properties: def.defaultProperties ?? ControllerProperties.empty,
      style: ControllerStyle.material, // TODO: pixel
      text: null);

  Stream<(ControllerWidgetDef, WidgetComponent)> looper() async* {
    for (final entry in controllerWidgetDef.entries) {
      if (entry == controllerWidgetDef.entries.first) continue;
      final def = entry.value;
      final component = getComponent(def);
      yield (def, component);
      setState(() {});
    }
  }

  void generateDocs(ControllerWidgetDef def, String output) {
    String doc = "";
    void appendDoc(String data) {
      doc += "$data\n";
    }

    void addTitle(String title) {
      appendDoc("$title\n");
    }

    final docOutput = join(output, "widgets", "${def.class_.name}.md");
    final imgOutput = join(output, "images", "${def.class_.name}.png");
    addTitle("# ${def.class_.name}");
    // image
    final component = def.component(
        class_: def.class_,
        id: 0,
        // TODO: size max ?
        position: Vector2(0, 0),
        properties: def.defaultProperties ?? ControllerProperties.empty,
        style: ControllerStyle.material, // TODO: pixel
        text: null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          final imagePath = await File(imgOutput).create().then((value) async =>
              await value
                  .writeAsBytes(image)
                  .then((value) => print("IMAGE $value written")));
          // await imagePath.writeAsBytes(image);
        }
      });
    });
    appendDoc("![${def.class_.name}](${imgOutput})\n");

    // description
    addTitle("# Description");

    appendDoc("${def.description}\n");

    // datasheet
    // - commitFrequency
    // - properties
    // - size
    addTitle("## Datasheet");
    doc += createTableMd([
      "Property",
      "Value"
    ], [
      {"Property": "Commitment", "Value": def.commitFrequency.name},
      {"Property": "Size", "Value": component.sizeFactor},
      {
        "Property": "Properties",
        "Value": def.defaultProperties?.toJson()
      }, // TODO: add common properties
    ]);
    doc += "\n\n";

    // API
    // - command
    // - result
    addTitle("## API");
    doc += createTableMd([
      "Property",
      "Value"
    ], [
      {"Property": "Command", "Value": def.command},
      {"Property": "Result", "Value": def.response},
    ]);
    doc += "\n\n";

    // Example
    addTitle("## Examples");
    appendDoc("```python");
    appendDoc("def ${def.command.toString().toLowerCase()}_1(*args):");
    appendDoc("    widget: ${def.command} = args[0]");
    appendDoc("    print('value', widget)"); // TODO: loop on attributes
    appendDoc(
        "server.register_action(1, '${def.command}', ${def.command.toString().toLowerCase()}_1)");

    // Resources
    addTitle("## Resources");
    appendDoc(
        "**API:** [${def.class_.name}](https://github.com/codde-pi/codde_protocol/)\n");

    // output
    final file = File(docOutput);
    file.createSync();
    file.writeAsStringSync(doc);
    print('FILE ${docOutput} written !');
  }
}
