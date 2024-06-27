import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:mobx/mobx.dart';

part 'controller_editor_store.g.dart';

class ControllerEditorStore = _ControllerEditorStore
    with _$ControllerEditorStore;

abstract class _ControllerEditorStore with Store {
  @observable
  ObservableList<WidgetComponent> doneList = ObservableList.of([]);

  @action
  void add(WidgetComponent widget) {
    doneList.add(widget);
  }
}
