import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:mobx/mobx.dart';

part 'add_widget_store.g.dart';

class AddWidgetStore = _AddWidgetStore with _$AddWidgetStore;

abstract class _AddWidgetStore with Store {
  @observable
  ControllerWidgetId? widget;

  _AddWidgetStore({this.widget});

  @computed
  int get page => widget != null ? 1 : 0;

  @action
  void selectWidget(ControllerWidgetId? widgetId) {
    widget = widgetId;
  }
}
