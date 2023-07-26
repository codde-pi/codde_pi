import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:mobx/mobx.dart';

part 'add_widget_store.g.dart';

class AddWidgetStore = _AddWidgetStore with _$AddWidgetStore;

abstract class _AddWidgetStore with Store {
  @observable
  ControllerWidgetDef? widget;

  _AddWidgetStore({this.widget});

  @computed
  int get page => widget != null ? 1 : 0;

  @action
  void selectWidget(ControllerWidgetDef? widgetId) {
    widget = widgetId;
  }
}
