import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:get/get.dart';

class AddWidgetController extends GetxController {
  ControllerWidgetId? widget;

  AddWidgetController({this.widget});

  int get page => widget != null ? 1 : 0;

  void selectWidget(ControllerWidgetId? widgetId) {
    widget = widgetId;
    update();
  }
}
