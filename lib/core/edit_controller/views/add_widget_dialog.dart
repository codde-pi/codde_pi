import 'package:codde_pi/core/edit_controller/state/add_widget_controller.dart';
import 'package:codde_pi/core/edit_controller/views/controller_widget_introduction.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWidgetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWidgetController>(
      init: AddWidgetController(), // INIT IT ONLY THE FIRST TIME
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(controller.widget != null
              ? controller.widget!.name
              : 'Select your widget'),
          leading: controller.widget != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => controller.selectWidget(null))
              : IconButton(
                  onPressed: () => Get.back(), icon: const Icon(Icons.close)),
        ),
        body: IndexedStack(
          index: controller.page,
          children: [
            AddWidgetList(),
            controller.widget != null
                ? ControllerWidgetIntroduction(widget: controller.widget!)
                : const Center(child: Text('No widget selected')),
          ],
        ),
        bottomNavigationBar: controller.widget != null
            ? ElevatedButton(
                onPressed: () => Get.back(result: controller.widget),
                child: const Text('SELECT'))
            : Container(),
      ),
    );
  }
}

class AddWidgetList extends StatelessWidget {
  final widgetList = controllerWidgetDef;
  final controller = Get.find<AddWidgetController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widgetList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(widgetList.values.elementAt(index).name),
              leading: Icon(Icons.gamepad_outlined),
              onTap: () =>
                  controller.selectWidget(widgetList.values.elementAt(index)),
            ));
  }
}
