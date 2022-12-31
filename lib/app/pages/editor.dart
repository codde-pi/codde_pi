import 'package:codde_pi/app/screens/controller.dart';
import 'package:codde_pi/app/dialogs/myp.dart';
import 'package:codde_pi/core/components/file_tree.dart';
import 'package:codde_pi/core/components/view.dart';
import 'package:codde_pi/services/controllers/parser.dart';
import 'package:codde_pi/services/hooks/editor.dart';
import 'package:codde_pi/services/providers/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:riverpod/riverpod.dart';

import '../../services/db/objects.dart';
import '../../services/editor/highlighter.dart';
import '../../services/editor/input.dart';

class EditorTab extends StatelessWidget {
  final String title;
  final int count;
  final bool selected;
  final Function select;

  const EditorTab(this.title, this.count, this.select,
      {this.selected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      child: ListTile(
        onTap: () {
          select(count);
        },
        selected: selected,
        selectedColor: Colors.orange,
        leading: const Icon(Icons.file_open),
        // TODO: extension <=> icon
        title: Text(title, softWrap: false),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            /*TODO*/
          },
        ),
      ),
    );
  }
}

enum TabSubject {
  form,
  file,
  controller,
}

class FileContent {
  /*
  * title: title,
  * tab: TabSubject
  * content: Document
  * path: Path
  */
  final String title;
  final TabSubject sjt; // TODO: répétition
  final CddPage page;
  final String path;

  FileContent(this.title, this.sjt, this.page, this.path);
}

class Editor extends StatefulWidget {
  String path;

  Editor({super.key, this.path = ''});

  @override
  State<StatefulWidget> createState() => _Editor();
}

class _Editor extends State<Editor> {
  FileTabManager fileTabManager = FileTabManager();

  /*var form = const MyP();
  var box = Hive.box('projects');
  var device = Device('Jerry', DeviceModel.rpi4,
      sshDevice: SSHDevice('192.168.4.40', 'P10u_p10u'));
  var projectTest = Project(DateTime.now(), DateTime.now(), 'test',
      device.toRepo('~'), 'this is a test', device);
  box.add(projectTest);*/

  @override
  void initState() {
    // fileTabManager.addContent(FileContent('Controller', TabSubject.controller,
    //     const CddPage('test', TabSubject.controller), ''));
    // contents.add(FileContent(
    //     'Form', TabSubject.form, const Page('', TabSubject.form), ''));
    super.initState();
  }

  void select(int count) {
    fileTabManager.openContent(count);
  }

  void createPage() {
    setState(() {
      var fileContent = FileContent(
          'File',
          TabSubject.file,
          const CddPage('/home/matt/Documents/gitlab-recovery-codes.txt',
              TabSubject.file),
          '/home/matt/Documents/gitlab-recovery-codes.txt');
      fileTabManager.addContent(fileContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider(
      create: (_) => fileTabManager,
      // TODO: isBrut mode
      builder: (BuildContext context, child) {
        var contents = context.watch<FileTabManager>().contents;
        var selected = context.watch<FileTabManager>().selectedContent;
        return Column(
          children: [
            Container(
              height: 40.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: contents.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index < contents.length
                      ? EditorTab(contents[index].title, index, select,
                          selected: index == selected)
                      : IconButton(
                          onPressed: createPage, icon: const Icon(Icons.add));
                },
                shrinkWrap: true,
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: FileTree('/home/matt/Projects/codde_pi/CoddePy'),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    flex: 3,
                    child: IndexedStack(
                        index: selected,
                        children: contents.map((e) => e.page).toList()),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
    return const MyP();
  }
}

class CddPage extends StatelessWidget {
  final String path;
  final TabSubject sjt;

  const CddPage(this.path, this.sjt, {super.key}); // TODO: redondance

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty || path == null) {
      return Center(
          child: TextButton(
        child: const Text('OPEN FILE'),
        onPressed: () {},
      )); // TODO
    }
    if (sjt == TabSubject.file) {
      final doc = DocumentProvider();
      return provider.MultiProvider(providers: [
        provider.FutureProvider(create: (_) => doc.openFile(path), initialData: null),
        provider.ChangeNotifierProvider(create: (context) => doc),
        provider.Provider(create: (context) => Highlighter()),
      ], child: const InputListener(child: View()));
    } else if (sjt == TabSubject.form) {
      return const MyP();
    } else if (sjt == TabSubject.controller) {
      return ControllerPage(path);
    } else {
      return const Center(child: Text("Unable to parse this file"));
    }
  }
}

class FileTabManager extends ChangeNotifier {
  final List<FileContent> contents = [];

  // FileContent? currentContent;
  int? selectedContent;

  void openContent(int index) {
    // currentContent = contents[index];
    selectedContent = index;
    notifyListeners();
  }

  void addContent(FileContent content) {
    contents.add(content);
    notifyListeners();
  }

  void insertContent(int index, FileContent content) {
    contents.insert(index, content);
    notifyListeners();
  }
}
