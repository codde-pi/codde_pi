import 'package:codde_editor/codde_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FileTab extends StatelessWidget {
  final String uid;

  bool get isFocused => uid == repo.focusedId;

  FileTab(this.uid, {super.key});

  FileStackManager repo = GetIt.I.get<FileStackManager>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) => SizedBox(
          key: key,
          width: 180.0,
          child: GestureDetector(
            onTap: () => repo.focus(uid),
            child: Container(
              color: isFocused ? Colors.grey.shade800 : Colors.transparent,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.file_open), //TODO: extension
                    Expanded(
                      flex: 1,
                      child: Text(repo.fileStacks[uid]!.name,
                          softWrap: false), // TODO: extension
                    ),
                    IconButton(
                      alignment: Alignment.center,
                      iconSize: 14.0,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        repo.closeFile(uid);
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class FileTabRow extends StatelessWidget {
  FileTabRow({super.key});
  FileStackManager repo = GetIt.I.get<FileStackManager>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
        height: 40.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: repo.fileStacks.length,
          itemBuilder: (BuildContext context, int index) {
            return FileTab(repo.fileStacks.values.elementAt(index).uid);
          },
          shrinkWrap: false,
        ),
      );
    });
  }
}
