import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'controller_widget_introduction.dart';
import 'store/add_widget_store.dart';

class AddWidgetDialog extends StatelessWidget {
  final AddWidgetStore state = AddWidgetStore();

  final Function(ControllerWidgetDef) funSelect;
  final Function funCancel;
  AddWidgetDialog(
      {super.key, required this.funSelect, required this.funCancel});
  @override
  Widget build(BuildContext context) {
    return Provider<AddWidgetStore>(
      create: (context) => state,
      lazy: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Observer(
              builder: (_) => Text(state.widget != null
                  ? state.widget!.class_.name
                  : 'Select your widget'),
            ),
            leading: state.widget != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => state.selectWidget(null))
                : IconButton(
                    onPressed: () => funCancel(),
                    icon: const Icon(Icons.close)),
            actions: [
              Observer(
                builder: (context) => ElevatedButton(
                  onPressed: state.widget != null
                      ? () => funSelect(state.widget!)
                      : null,
                  child: const Text('VALIDATE'),
                ),
              )
            ],
          ),
          body: Observer(
            builder: (_) => IndexedStack(
              sizing: StackFit.expand,
              index: state.page,
              children: [
                AddWidgetList(),
                state.widget != null
                    ? ControllerWidgetIntroduction(widget: state.widget!)
                    : const Center(child: Text('No widget selected')),
              ],
            ),
          ),
          bottomNavigationBar: state.widget != null
              ? ElevatedButton(
                  onPressed: state.widget != null
                      ? () => funSelect(state.widget!)
                      : null,
                  child: const Text('SELECT'))
              : null,
        ),
      ),
    );
  }
}

class AddWidgetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddWidgetStore>(context);
    return ListView.builder(
      itemCount: controllerWidgetDef.length,
      itemBuilder: (context, index) => Card(
          child: ListTile(
        title: Text(controllerWidgetDef.values.elementAt(index).class_.name),
        leading: const Icon(Icons.gamepad_outlined),
        onTap: () => controller
            .selectWidget(controllerWidgetDef.values.elementAt(index)),
      )),
    );
  }
}

/* class AddWidgetSheet extends BottomSheet {
  AddWidgetSheet({super.key})
      : super(
            onClosing: () {},
            builder: (context) => Container(color: Colors.red));
  @override
  WidgetBuilder get builder => (context) => AddWidgetDialog();
  // TODO: hide FAB, then modify it to validiate wiget selection
} */
