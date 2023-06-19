import 'package:controller_widget_api/controller_widget_api.dart';

const controllerWidgetDef = {
  'simple_button': ControllerWidgetId(
      class_: ControllerClass.simple_button,
      description: 'simple button description',
      name: "Simple Button",
      api: [ControllerApiAttribute(key: null, valueType: 'boolean')],
      commitFrequency: ControllerCommitFrequency.triggered),
};
