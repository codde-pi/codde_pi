import 'package:codde_pi/components/codde_terminal/codde_terminal_view.dart';
import 'package:codde_pi/components/toolbar/toolbar.dart';
import 'package:flutter/material.dart';

class CoddeTerminal extends StatelessWidget {
  CoddeTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: null),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ToolBar(child: const CoddeTerminalView()),
      ),
    );
  }
}
