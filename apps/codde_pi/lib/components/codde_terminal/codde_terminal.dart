import 'package:codde_pi/components/codde_terminal/codde_terminal_view.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_menu.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/toolbar/toolbar.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoddeTerminal extends DynamicBarWidget {
  CoddeTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(leading: null),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Provider<ToolBarStore>(
            create: (_) => ToolBarStore(),
            child: ToolBar(child: CoddeTerminalView())),
      ),
    );
  }

  @override
  setFab(BuildContext context) {
    bar.disableFab();
  }

  @override
  void setIndexer(context) {}

  @override
  List<DynamicBarMenuItem>? get bottomMenu => null;
}
