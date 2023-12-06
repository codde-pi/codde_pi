import 'package:codde_backend/codde_backend.dart';
import 'package:codde_editor/codde_editor.dart' as cdd;
import 'package:codde_editor/codde_editor.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:file_stack_repository/file_stack_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CoddeEditor extends DynamicBarWidget {
  String path;
  CoddeBackend backend;
  // CodeFieldRepository? fileStackInstance;
  ThemeData? materialThemeData;
  CodeThemeData? codeThemeData;
  TreeViewTheme? treeViewTheme;
  late FileStackRepository repo;
  CoddeEditor(
      {super.key,
      this.path = '',
      CoddeBackend? backend,
      // this.fileStackInstance,
      this.materialThemeData,
      this.codeThemeData,
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
    if (!GetIt.I.isRegistered<FileStackRepository>()) {
      repo = GetIt.I.registerSingleton<FileStackRepository>(
          FileStackRepository(backend: backend, mode: FileStackMode.single));
    } else {
      repo = GetIt.I.get<FileStackRepository>();
    }
    final provider = Provider.of<CoddeState>(context);

    /* GetIt.I.registerLazySingleton<ThemeData>(
        () => materialThemeData ?? theme.defaultTheme);
    GetIt.I.registerLazySingleton<CodeThemeData>(
        () => codeThemeData ?? theme.codeTheme);
    GetIt.I.registerLazySingleton<TreeViewTheme>(
        () => treeViewTheme ?? theme.treeViewTheme); */

    return cdd.CoddeEditor(path: provider.project.path);
  }

  @override
  void setIndexer(context) {}

  @override
  get bottomMenu => null;
}
