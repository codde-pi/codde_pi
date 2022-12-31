import 'dart:io';

import 'package:codde_pi/app/pages/editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class FileTree extends StatefulWidget {
  String path;

  FileTree(this.path);

  @override
  State<StatefulWidget> createState() => _FileTree();
}

class _FileTree extends State<FileTree> {
  FileItemProvider fileItemProvider = FileItemProvider();
  final double PADDING = 50.0;

  void listFiles(String path, int? startIndex, {double padding = 0.0}) {
    var list = Directory(path).listSync().asMap().map((key, e) {
      /*Provider(create: (context) => FileItemProvider(), builder: (context, data) { var fileItem = */
      int index = startIndex != null ? startIndex + key + 1 : 0 + key;
      fileItemProvider.previewItems(index);
      FileItem fileItem = FileItem(
        // TODO: keep provider ?
        e,
        ListTile(
          contentPadding: EdgeInsets.only(left: padding),
          title: Text(e.path.split('/').last),
          onTap: () => open(e.path, index, index == fileItemProvider.selectedFile),
        ),
        childrenNb: null, //isDirectory(path),
      );
      fileItemProvider.replaceItems(index, [fileItem]);
      return MapEntry(key, fileItem);
    }).values.toList();
    if (startIndex != null) {
      fileItemProvider.updateFolder(startIndex, list.length);
    }
  }

  Future<int?> isDirectory(String path) async {
    var rst = FileSystemEntity.isDirectory(path).then((value) {
      if (value) {
        return 0;
      } else {
        return null;
      }
    });
    return await rst;
  }

  @override
  void initState() {
    listFiles(widget.path, null);
    super.initState();
  }

  void open(String path, int index, bool selected) async {
    var chNb = fileItemProvider.files[index].childrenNb;
    if (chNb == null) {
      fileItemProvider.updateFolder(index, await isDirectory(path));
    }
    chNb = fileItemProvider.files[index].childrenNb;
    print('chNb $chNb');
    if (chNb != null) {
      // this is a folder
      if (chNb > 0) {
        // close subfolders
        fileItemProvider.removeItems(index + 1, (index + 1) + chNb);
      } else {
        // open subfolders
        listFiles(path, index);
      }
    } else {
      // this is a file
      FileTabManager provider = Provider.of(context, listen: false);
      int? selectedContent = provider.selectedContent;
      provider.insertContent(
          selectedContent != null ? selectedContent + 1 : provider.contents.isEmpty ? 0 : provider.contents.length - 1,
          FileContent(path.split("/").last, path.split("/").last.split('.').last == "cjson" ? TabSubject.controller : TabSubject.file,
              CddPage(path, path.split("/").last.split('.').last == "cjson" ? TabSubject.controller : TabSubject.file), path));
      provider.openContent(selectedContent != null ? (selectedContent + 1) : provider.contents.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => fileItemProvider,
      builder: (context, data) => ListView.builder(
        itemCount: context.watch<FileItemProvider>().files.length,
        itemBuilder: (context, int index) {
          return context.watch<FileItemProvider>().files[index].tile;
        },
      ),
    );
  }
}

class FileItem {
  FileSystemEntity file;
  ListTile tile;
  int? childrenNb;

  FileItem(this.file, this.tile, {this.childrenNb});

  get isFolderOpen => childrenNb != null && childrenNb! > 0;

  get isDirectory => childrenNb != null;
}

class FileItemProvider extends ChangeNotifier {
  List<FileItem> files = [];
  int? selectedFile;

  FileItemProvider();

  void updateFolder(int index, int? childrenNb) {
    files[index].childrenNb = childrenNb;
    notifyListeners();
  }

  bool insertable(index) {
    return index >= files.length;
  }

  void insertItems(int index, List<FileItem> items) {
    if (!insertable(index)) {
      files.addAll(items);
    } else {
      files.insertAll(index, items);
    }
    notifyListeners();
  }

  void removeItems(int start, int end) {
    files.removeRange(start, end);
    files[start - 1].childrenNb = 0;
    notifyListeners();
  }

  void previewItems(int index, {int? count}) {
    FileItem item = FileItem(
      File('dummy'),
      ListTile(
        title: const Text('dummy'),
        onTap: () {},
      ),
    );
    if (count != null) {
      if (index >= files.length) {
        files.addAll(Iterable.generate(count, (ndx) => item));
      } else {
        files.insertAll(index, Iterable.generate(count, (ndx) => item));
      }
    } else {
      if (index >= files.length) {
        files.add(item);
      } else {
        files.insert(index, item);
      }
    }
    notifyListeners();
  }

  void replaceItems(int startIndex, List<FileItem> items) {
    files.replaceRange(startIndex, startIndex + items.length, items);
    notifyListeners();
  }
}
