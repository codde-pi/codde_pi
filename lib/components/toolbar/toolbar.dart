import 'package:codde_pi/components/toolbar/toolbar_event.dart';
import 'package:codde_pi/components/toolbar/toolbar_store.dart';
import 'package:codde_pi/components/utils/footer_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatelessWidget {
  Widget child;
  ToolBar({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ToolBarStore>(context);
    return Provider(
      create: (_) => store,
      child: FooterLayout(
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
                onPressed: () => store.ctrlKey(),
                //style: ButtonStyle(padding: 2.0),
                child: Text(
                  'CTRL',
                  style: TextStyle(
                      color: (store.ctrlEnabled)
                          ? Theme.of(context).highlightColor
                          : Theme.of(context).unselectedWidgetColor),
                ),
              ),

              //SizedBox(width: space),
              TextButton(
                onPressed: () => store.altKey(),
                child: Text(
                  'ALT',
                  style: TextStyle(
                      color: store.altEnabled
                          ? Theme.of(context).highlightColor
                          : Theme.of(context).unselectedWidgetColor),
                ),
              ),
              //SizedBox(width: space),
              TextButton(
                onPressed: () {
                  store.sendEvent(ToolBarEvent.tab);
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
                  store.sendEvent(ToolBarEvent.west);
                },
              ),
              IconButton(
                icon: const Icon(Icons.north),
                color: Color(Colors.white.value),
                onPressed: () {
                  store.sendEvent(ToolBarEvent.north);
                },
              ),
              IconButton(
                icon: const Icon(Icons.south),
                color: Color(Colors.white.value),
                onPressed: () {
                  store.sendEvent(ToolBarEvent.south);
                },
              ),
              IconButton(
                icon: const Icon(Icons.east),
                color: Color(Colors.white.value),
                onPressed: () {
                  store.sendEvent(ToolBarEvent.east);
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
      ),
    );
  }
}
