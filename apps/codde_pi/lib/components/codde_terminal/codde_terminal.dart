import 'dart:async';

import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_terminal/codde_terminal_view.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pty/flutter_pty.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';
import 'package:codde_pi/components/toolbar/toolbar.dart';

class CoddeTerminal extends StatefulWidget {
  CoddeTerminal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoddeTerminal();
  }
}

class _CoddeTerminal extends State<CoddeTerminal> {
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
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => {},
          ),
        ],
      ),
      body: SafeArea(
          maintainBottomViewPadding: true,
          child: ToolBar(
            child: CoddeTerminalView(),
            env: ToolBarEnv.terminal,
          )),
    );
    // });
  }
}
