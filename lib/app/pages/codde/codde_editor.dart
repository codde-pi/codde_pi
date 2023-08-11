import 'package:codde_backend/codde_backend.dart';
import 'package:codde_editor/codde_editor.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_editor/src/services/editor/code_field_repository.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CoddeEditor extends DynamicBarWidget {
  String path;
  CoddeBackend backend;
  CodeFieldRepository? fileStackInstance;
  ThemeData? materialThemeData;
  CodeThemeData? codeThemeData;
  TreeViewTheme? treeViewTheme;
  CoddeEditor(
      {super.key,
      this.path = '',
      CoddeBackend? backend,
      this.fileStackInstance,
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
        action: () {
          /* TODO: open dialog to repo.createFile(fileNameController.text) */
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!GetIt.I.isRegistered<CoddeBackend>()) {
      GetIt.I.registerLazySingleton(() => backend);
    }
    if (!GetIt.I.isRegistered<CodeFieldRepository>()) {
      GetIt.I.registerLazySingleton<CodeFieldRepository>(
          () => fileStackInstance ?? CodeFieldRepository());
    }
    final provider = Provider.of<CoddeEditorCubit?>(context);

    /* GetIt.I.registerLazySingleton<ThemeData>(
        () => materialThemeData ?? theme.defaultTheme);
    GetIt.I.registerLazySingleton<CodeThemeData>(
        () => codeThemeData ?? theme.codeTheme);
    GetIt.I.registerLazySingleton<TreeViewTheme>(
        () => treeViewTheme ?? theme.treeViewTheme); */

    return provider != null
        ? CoddeEditorView(provider.state.path)
        : BlocProvider(
            create: (_) => CoddeEditorCubit(path: path),
            child: CoddeEditorView(path));
  }
}
