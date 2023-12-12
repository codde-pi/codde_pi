import 'package:codde_backend/codde_backend.dart';
import 'package:codde_editor/codde_editor.dart';
import 'package:codde_editor/codde_editor.dart' as codde_editor;
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/create_file_dialog.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/core/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:collapsible/collapsible.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'store/codde_editor_store.dart';

/// Main Editor view
class CoddeEditor extends DynamicBarWidget {
  String path;
  CoddeBackend backend;
  // CodeFieldRepository? fileStackInstance;
  ThemeData? materialThemeData;
  TreeViewTheme? treeViewTheme;
  late FileStackManager repo;
  late final store = CoddeEditorStore();
  CoddeEditor(
      {super.key,
      this.path = '',
      CoddeBackend? backend,
      // this.fileStackInstance,
      this.materialThemeData,
      this.treeViewTheme})
      : backend = backend ?? CoddeBackend(BackendLocation.local);
  // TODO: hive instance/location
  // TODO: option "single tab"
  @override
  void setFab(BuildContext context) {
    bar.setFab(
        iconData: Icons.add,
        action: () async {
          final res = await showDialog(
              context: context, builder: (context) => CreateFileDialog());
          repo.createFile(res);
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.registerLazySingleton(() => backend);
    }
    if (!GetIt.I.isRegistered<FileStackManager>()) {
      repo = GetIt.I.registerSingleton<FileStackManager>(
          FileStackManager(backend: backend, mode: FileStackMode.single));
    } else {
      repo = GetIt.I.get<FileStackManager>();
    }
    final provider = Provider.of<CoddeState>(context);
    final isMobile = ResponsiveTools.screenType(MediaQuery.of(context).size) ==
        DeviceScreenType.mobile;

    /* GetIt.I.registerLazySingleton<ThemeData>(
        () => materialThemeData ?? theme.defaultTheme);
    GetIt.I.registerLazySingleton<TreeViewTheme>(
        () => treeViewTheme ?? theme.treeViewTheme); */

    return Observer(
      builder: (_) => Scaffold(
        key: store.scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Scaffold.of(context).openDrawer();
                store.openDrawer();
              });
            },
          ),
          title: repo.singleTabMode
              ? Text(repo.focused?.name ?? '')
              : FileTabRow(),
          actions: [
            Observer(builder: (context) {
              return repo.focused != null &&
                      repo.focused?.status == FileStackStatus.editing
                  ? IconButton(
                      onPressed: () {
                        String? currentId = repo.focusedId;
                        if (currentId != null) {
                          repo.saveFile(repo.focusedId!);
                        }
                      },
                      icon: const Icon(Icons.save))
                  : Container();
            })
          ],
        ),
        drawer: isMobile
            ? Drawer(
                width: 300.0,
                child: Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: FileTreeView(path)))
            : null,
        body: !isMobile
            ? Row(
                children: [
                  Collapsible(
                    axis: CollapsibleAxis.vertical,
                    duration: const Duration(milliseconds: 5),
                    curve: Curves.bounceInOut,
                    collapsed: store.fileTreeOpen,
                    child: Container(
                      width: store.fileTreeWidth,
                      child: FileTreeView(path),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        final direction = details.delta.direction;
                        int lr;
                        if (direction.abs() <= math.pi / 2) {
                          lr = 1;
                        } else {
                          lr = -1;
                        }
                        store.updateFileTreeWidth(details.delta.distance * lr);
                      },
                      onHorizontalDragEnd: (details) =>
                          store.saveFileTreeWidth(),
                      onHorizontalDragCancel: () => store.saveFileTreeWidth(),
                      child: const VerticalDivider(
                        thickness: 3.0,
                      ),
                    ),
                  ),
                  Expanded(child: FileView()),
                ],
              )
            : FileView(),
      ),
    );
  }

  @override
  void setIndexer(context) {}

  @override
  get bottomMenu => null;
}
