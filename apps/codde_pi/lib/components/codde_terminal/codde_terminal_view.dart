import 'dart:async';
import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_terminal/toolbar_event_handler.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_pty/flutter_pty.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';

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
  late ToolBarNotifier toolBarNotifier;
  StreamSubscription? stdoutListener;
  StreamSubscription? stderrListener;

  @override
  void initState() {
    super.initState();
    initSshTerminal(context);
    toolBarNotifier = Provider.of<ToolBarNotifier>(context, listen: false);
    toolBarNotifier.addListener(() {
      final event = toolBarNotifier.event;
      logger.d('EVENT $event');
      if (event != null) {
        final String? char = toolBarNotifier.handleEvent();
        if (char != null) terminal?.write(char);
      }
    });
  }

  /// Handle control key
  KeyEventResult onKeyEvent(terminal, KeyEvent event) {
    if (toolBarNotifier.ctrlEnabled) {
      toolBarNotifier.ctrlKey();
      switch (event.logicalKey.keyLabel.toUpperCase()) {
        case 'A':
          terminal.write(String.fromCharCode(1)); // Ctrl + A
          break;
        case 'B':
          terminal.write(String.fromCharCode(2)); // Ctrl + B
          break;
        case 'C':
          terminal.write(String.fromCharCode(3)); // Ctrl + C
          break;
        case 'D':
          terminal.write(String.fromCharCode(4)); // Ctrl + D
          break;
        case 'E':
          terminal.write(String.fromCharCode(5)); // Ctrl + E
          break;
        case 'F':
          terminal.write(String.fromCharCode(6)); // Ctrl + F
          break;
        case 'G':
          terminal.write(String.fromCharCode(7)); // Ctrl + G
          break;
        case 'H':
          terminal.write(String.fromCharCode(8)); // Ctrl + H
          break;
        case 'I':
          terminal.write(String.fromCharCode(9)); // Ctrl + I
          break;
        case 'J':
          terminal.write(String.fromCharCode(10)); // Ctrl + J
          break;
        case 'K':
          terminal.write(String.fromCharCode(11)); // Ctrl + K
          break;
        case 'L':
          terminal.write(String.fromCharCode(12)); // Ctrl + L
          break;
        case 'M':
          terminal.write(String.fromCharCode(13)); // Ctrl + M
          break;
        case 'N':
          terminal.write(String.fromCharCode(14)); // Ctrl + N
          break;
        case 'O':
          terminal.write(String.fromCharCode(15)); // Ctrl + O
          break;
        case 'P':
          terminal.write(String.fromCharCode(16)); // Ctrl + P
          break;
        case 'Q':
          terminal.write(String.fromCharCode(17)); // Ctrl + Q
          break;
        case 'R':
          terminal.write(String.fromCharCode(18)); // Ctrl + R
          break;
        case 'S':
          terminal.write(String.fromCharCode(19)); // Ctrl + S
          break;
        case 'T':
          terminal.write(String.fromCharCode(20)); // Ctrl + T
          break;
        case 'U':
          terminal.write(String.fromCharCode(21)); // Ctrl + U
          break;
        case 'V':
          terminal.write(String.fromCharCode(22)); // Ctrl + V
          break;
        case 'W':
          terminal.write(String.fromCharCode(23)); // Ctrl + W
          break;
        case 'X':
          terminal.write(String.fromCharCode(24)); // Ctrl + X
          break;
        case 'Y':
          terminal.write(String.fromCharCode(25)); // Ctrl + Y
          break;
        case 'Z':
          terminal.write(String.fromCharCode(26)); // Ctrl + Z
          break;
        default:
          return KeyEventResult.ignored;
      }
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
    super.didUpdateWidget(oldWidget);
    // terminal.buffer
  }

  Future<SSHSession?> initSshTerminal(BuildContext context) async {
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

    /* return FutureBuilder(
        future: initSshTerminal(context),
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
 */
    return TerminalView(
      terminal,
      theme: TerminalThemes.defaultTheme,
      // onKeyEvent: onKeyEvent,
    );
    // });
  }
}
