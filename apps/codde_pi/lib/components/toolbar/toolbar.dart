import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:codde_pi/components/utils/footer_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';

class ToolBar extends StatelessWidget {
  Widget child;
  ToolBarEnv env;
  ToolBar({super.key, required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToolBarNotifier>(
      create: (_) => ToolBarNotifier(env: env),
      builder: (context, _) => ToolBarView(child: child),
    );
  }
}

class ToolBarView extends StatelessWidget {
  Widget child;
  ToolBarView({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ToolBarNotifier>(context, listen: false);
    return FooterLayout(
      footer: Observer(
        builder: (_) => Row(
          //todo: ESC button ? \u001B
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IconButton(icon: Icon(Icons.close), onPressed: () {  },),
            //SizedBox(width: space),

            TextButton(
              onPressed: () => notifier.ctrlKey(),
              //style: ButtonStyle(padding: 2.0),
              child: Consumer<ToolBarNotifier>(
                builder: (context, toolbar, child) => Text(
                  'CTRL',
                  style: TextStyle(
                      color: (toolbar.ctrlEnabled)
                          ? Colors.blue
                          : Theme.of(context).unselectedWidgetColor),
                ),
              ),
            ),

            //SizedBox(width: space),
            /* TextButton(
              onPressed: () => notifier.altKey(),
              child: Consumer<ToolBarNotifier>(
                builder: (context, toolbar, child) => Text(
                  'ALT',
                  style: TextStyle(
                      color: toolbar.altEnabled
                          ? Theme.of(context).highlightColor
                          : Theme.of(context).unselectedWidgetColor),
                ),
              ),
            ), */
            //SizedBox(width: space),
            TextButton(
              onPressed: () {
                notifier.sendEvent(TerminalKey.tab);
              },
              child: Text(
                'TAB',
                style: TextStyle(
                    color: Color(Colors.white
                        .value)), // Theme.of(context).unselectedWidgetColor),
              ),
            ),
            //SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(Icons.west),
              color: Color(Colors.white.value),
              onPressed: () {
                notifier.sendEvent(TerminalKey.arrowLeft);
              },
            ),
            IconButton(
              icon: const Icon(Icons.north),
              color: Color(Colors.white.value),
              onPressed: () {
                notifier.sendEvent(TerminalKey.arrowUp);
              },
            ),
            IconButton(
              icon: const Icon(Icons.south),
              color: Color(Colors.white.value),
              onPressed: () {
                notifier.sendEvent(TerminalKey.arrowDown);
              },
            ),
            IconButton(
              icon: const Icon(Icons.east),
              color: Color(Colors.white.value),
              onPressed: () {
                notifier.sendEvent(TerminalKey.arrowRight);
              },
            ),
            /*IconButton(
          icon: Icon(Icons.send),
          color: Theme.of(context).highlightColor,
          onPressed: () {
            specialKey.resetAll();
            setState(() {});
            // terminal.write('\x1B[${commandLength}D\x1B[0K');
        },),*/
          ],
        ),
      ),
      child: child,
    );
  }
}

enum ToolBarEnv { terminal, editor }
