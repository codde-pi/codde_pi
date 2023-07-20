import 'package:codde_pi/core/edit_controller/state/add_widget_store.dart';
import 'package:codde_pi/core/edit_controller/views/controller_widget_introduction.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddWidgetDialog extends Dialog {
  final AddWidgetStore state = AddWidgetStore();

  AddWidgetDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Provider<AddWidgetStore>(
        create: (_) => state,
        lazy: false,
        child: Observer(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text(state.widget != null
                  ? state.widget!.name
                  : 'Select your widget'),
              leading: state.widget != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => state.selectWidget(null))
                  : IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
            ),
            body: IndexedStack(
              index: state.page,
              children: [
                AddWidgetList(),
                state.widget != null
                    ? ControllerWidgetIntroduction(widget: state.widget!)
                    : const Center(child: Text('No widget selected')),
              ],
            ),
            bottomNavigationBar: state.widget != null
                ? ElevatedButton(
                    onPressed: () => Navigator.pop(context, state.widget),
                    child: const Text('SELECT'))
                : Container(),
          ),
        ),
      ),
    );
  }
}

class AddWidgetList extends StatelessWidget {
  final widgetList = controllerWidgetDef;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddWidgetStore>(context);
    return ListView.builder(
        itemCount: widgetList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(widgetList.values.elementAt(index).name),
              leading: const Icon(Icons.gamepad_outlined),
              onTap: () =>
                  controller.selectWidget(widgetList.values.elementAt(index)),
            ));
  }
}
