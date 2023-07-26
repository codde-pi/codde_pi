import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:controller_widget_api/controller_widget_api.dart';

const controllerWidgetDef = {
  'simple_button': ControllerWidgetDef(
      class_: ControllerClass.simple_button,
      description: 'simple button description',
      name: "Simple Button",
      api: [ControllerApiAttribute(key: null, valueType: 'boolean')],
      commitFrequency: ControllerCommitFrequency.triggered,
      size: 1),
  'unknown': ControllerWidgetDef(
      class_: ControllerClass.unknown,
      description: "Unknown button fallback",
      name: "Unknown button",
      api: [],
      size: 0),
  'joystick': ControllerWidgetDef(
      class_: ControllerClass.joystick,
      description: "Unknown button fallback",
      name: "Unknown button",
      api: [],
      size: 0)
};
