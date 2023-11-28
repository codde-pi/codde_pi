import 'dart:convert';

import 'package:codde_pi/components/codde_runner/store/codde_runner_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';

class RuntimeStdView extends StatelessWidget {
  final Terminal terminal =
      Terminal(maxLines: 100000, onBell: () => HapticFeedback.vibrate());
  final String? initial;
  late CoddeRunnerStore runnerStore;

  RuntimeStdView([this.initial]);

  void initSshTerminal() {
    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    /* TODO: terminal.onTitleChange = (title) {
      setState(() => this.title = title);
    }; */

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      runnerStore.session
          ?.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    if (initial != null) terminal.write(initial!);

    terminal.onOutput = (data) {
      runnerStore.session?.write(utf8.encode(data) as Uint8List);
    };
    runnerStore.session?.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen((char) {
      terminal.write(char);
      runnerStore.writeStd(char);
    });

    runnerStore.session?.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen((char) {
      terminal.write(char);
      runnerStore.writeStd(char);
    });
  }

  @override
  Widget build(BuildContext context) {
    runnerStore = Provider.of<CoddeRunnerStore>(context);
    initSshTerminal();
    return TerminalView(
      terminal,
      theme: TerminalThemes.defaultTheme,
    );
  }
}
