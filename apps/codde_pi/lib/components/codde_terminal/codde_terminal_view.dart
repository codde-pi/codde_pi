import 'dart:async';
import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';
import 'package:xterm/src/ui/input_map.dart' as inputMap;

class CoddeTerminalView extends StatefulWidget {
  CoddeTerminalView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoddeTerminalView();
  }
}

class _CoddeTerminalView extends State<CoddeTerminalView> {
  // final backend = GetIt.I.get<CoddeBackend>();
  String title = '';
  Terminal terminal = Terminal(
    maxLines: 100000,
    onBell: () => HapticFeedback.vibrate(),
  );
  final CoddeBackend backend = getBackend();
  late ToolBarNotifier toolBarNotifier =
      Provider.of<ToolBarNotifier>(context, listen: false);

  StreamSubscription? stdoutListener;
  StreamSubscription? stderrListener;

  late final loadTerminal = initSshTerminal();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // initSshTerminal();
    // toolBarNotifier = Provider.of<ToolBarNotifier>(context, listen: false);
    toolBarNotifier.addListener(() {
      final event = toolBarNotifier.event;
      logger.d('EVENT $event');
      if (event != null) {
        final TerminalKey? input = toolBarNotifier.consumeEvent();
        if (input != null) terminal.keyInput(input);
      }
    });
  }

  /// Handle control key
  KeyEventResult onKeyEvent(focusNode, KeyEvent event) {
    if (toolBarNotifier.ctrlEnabled) {
      toolBarNotifier.ctrlKey();
      final termKey = inputMap.keyToTerminalKey(event.logicalKey);
      if (termKey == null) return KeyEventResult.ignored;
      terminal.keyInput(termKey, ctrl: true);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    super.dispose();
    closeTerminal();
  }

  @override
  didUpdateWidget(CoddeTerminalView oldWidget) {
    _focus.unfocus();
    super.didUpdateWidget(oldWidget);
    // terminal.buffer
  }

  Future<SSHSession?> initSshTerminal() async {
    print('INITIALIZE SSH TERMINAL');
    logger.i("initialization");
    terminal.write('Connecting...\r\n');
    if (backend.location != BackendLocation.server) {
      throw Exception("Bad backend location");
    }
    if (!backend.isOpen) {
      await backend.open();
    }
    if (!backend.isRunning) throw Exception("Backend is not running");
    if (backend.shell != null) return backend.shell;
    backend.shell ??= await backend.client?.shell(
        pty: SSHPtyConfig(
            width: terminal!.viewWidth, height: terminal!.viewHeight));
    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    // terminal.buffer.clear();
    // terminal.buffer.setCursor(0, 0);

    terminal?.onTitleChange = (title) {
      // setState(() => this.title = title);
    };

    terminal?.onResize = (width, height, pixelWidth, pixelHeight) {
      backend.shell?.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal?.onOutput = (data) {
      backend.shell?.write(utf8.encode(data));
    };

    /* stdoutListener = */ backend.shell!.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    /* stderrListener = */ backend.shell!.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);
    return backend.shell;
  }

  @action
  void closeTerminal() {
    logger.i("dispose");
    stderrListener?.cancel();
    stdoutListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // final toolBarStore = Provider.of<ToolBarStore>(context);

    return FutureBuilder(
        future: loadTerminal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data == null) {
            return const Text('Terminal instance has not been initialized');
          }

          return TerminalView(
            terminal,
            focusNode: _focus,
            theme: TerminalThemes.defaultTheme,
            onKeyEvent: onKeyEvent,
          );
        });
  }
}
