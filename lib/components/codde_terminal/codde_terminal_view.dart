import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_terminal/toolbar_event_handler.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';

class CoddeTerminalView extends StatefulWidget {
  const CoddeTerminalView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoddeTerminalView();
  }
}

class _CoddeTerminalView extends State<CoddeTerminalView> {
  late SSHSession? shell;
  late final Pty pty;
  final backend = GetIt.I.get<CoddeBackend>();
  String title = '';
  Terminal terminal =
      Terminal(maxLines: 100000, onBell: () => HapticFeedback.vibrate());
  // final keyboard = VirtualKeyboard(defaultInputHandler);
  @override
  void initState() {
    super.initState();
    if (backend.location == BackendLocation.server) {
      initSshTerminal();
    } else {
      initPty();
    }
  }

  void initShell() async {
    shell = await backend.session.shell(
        pty: SSHPtyConfig(
            width: terminal.viewWidth, height: terminal.viewHeight));
  }

  Future<void> initSshTerminal() async {
    shell = await backend.session.shell(
        pty: SSHPtyConfig(
            width: terminal.viewWidth, height: terminal.viewHeight));
    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onTitleChange = (title) {
      setState(() => this.title = title);
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      shell?.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      shell?.write(utf8.encode(data) as Uint8List);
    };

    shell!.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    shell!.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);
  }

  void initPty() {
    pty = Pty.start(
      'sh', // bash
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
        .cast<List<int>>()
        .transform(Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStore = Provider.of<ToolBarStore>(context);
    return ReactionBuilder(
        child: TerminalView(
          terminal,
          theme: TerminalThemes.defaultTheme,
        ),
        builder: (_) => reaction((_) => toolBarStore.event, (event) {
              if (event != null) {
                final String? char = handleEvent(event);
                if (char != null) terminal.write(char);
              }
            }));
  }
}
