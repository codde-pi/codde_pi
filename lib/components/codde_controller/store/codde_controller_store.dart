import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:mobx/mobx.dart';

part 'codde_controller_store.g.dart';

class CoddeControllerStore = _CoddeControllerStore with _$CoddeControllerStore;

abstract class _CoddeControllerStore with Store {
  @observable
  ControllerWidgetMode mode;

  _CoddeControllerStore({this.mode = ControllerWidgetMode.player});

  @action
  void editMode() {
    mode = ControllerWidgetMode.editor;
  }

  @action
  void playMode() {
    mode = ControllerWidgetMode.player;
  }

  @action
  void toggleMode() {
    mode == ControllerWidgetMode.editor
        ? ControllerWidgetMode.player
        : ControllerWidgetMode.editor;
  }
}
