import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/xt256.dart' as codeTheme;
import 'package:highlight/languages/python.dart';

class CodeWriter extends StatelessWidget {
  Function? funBack;
  CoddeBackend backend;
  CodeWriter(
      {Key? key,
      required this.path,
      this.readOnly = false,
      this.funBack,
      CoddeBackend? backend})
      : backend = backend ?? getLocalBackend(),
        super(key: key);
  final String path;
  bool readOnly;
  late final controller = CodeController(
    text: 'Loading...', // Initial code
    language: python,
  );
  ValueNotifier<bool> saved = ValueNotifier<bool>(true);

  void save() {
    backend.save(path, controller.text);
    saved.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basename(path)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                funBack != null ? funBack!() : Navigator.of(context).pop()),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: saved,
            builder: (context, __, _) => IconButton(
                onPressed: () => save(),
                icon: Icon(Icons.save,
                    color: saved.value
                        ? Theme.of(context).disabledColor
                        : Colors.blue)),
          ),
        ],
      ),
      body: FutureBuilder(
          future: backend.readSync(path),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              controller.text = snapshot.data!;
            }
            return CodeTheme(
              data: CodeThemeData(styles: codeTheme.xt256Theme),
              child: SingleChildScrollView(
                child: CodeField(
                  background: Theme.of(context).colorScheme.background,
                  onChanged: (value) => saved.value = false,
                  controller: controller,
                ),
              ),
            );
          }),
    );
  }
}
