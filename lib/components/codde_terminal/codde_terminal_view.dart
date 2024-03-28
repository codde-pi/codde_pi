import 'dart:async';
import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/codde_terminal/toolbar_event_handler.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
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
  final backend = GetIt.I.get<CoddeBackend>();
  String title = '';
  late Terminal terminal;
  late CoddeState state;
  // Terminal terminal =
  //     Terminal(maxLines: 100000, onBell: () => HapticFeedback.vibrate());
  // bool initialized = false;
  // final keyboard = VirtualKeyboard(defaultInputHandler);

  @override
  void initState() {
    super.initState();
    // initSshTerminal();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  didUpdateWidget(CoddeTerminalView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // terminal.buffer
  }

  @override
  Widget build(BuildContext context) {
    final toolBarStore = Provider.of<ToolBarStore>(context);
    state = Provider.of<CoddeState>(context, listen: false);
    return FutureBuilder(
        future: /* initialized ? Future.value() : */
            state.initSshTerminal(context, backend),
        builder: (context, snapshot) {
          terminal = state.terminal!;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return ReactionBuilder(
              child: TerminalView(
                terminal,
                theme: TerminalThemes.defaultTheme,
              ),
              builder: (_) => reaction((_) => toolBarStore.event, (event) {
                    logger.d('EVENT');
                    if (event != null) {
                      final String? char = handleEvent(event);
                      if (char != null) terminal.write(char);
                    }
                  }));
        });
  }
}
