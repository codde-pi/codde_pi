import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mobx/mobx.dart';

part 'codde_device_store.g.dart';

class CoddeDeviceStore = _CoddeDeviceStore with _$CoddeDeviceStore;

abstract class _CoddeDeviceStore with Store {
  _CoddeDeviceStore(this.props);
  @observable
  ControllerProperties? props;
  @observable
  bool uiSelectDevice = false;

  @action
  void openSelectDevice() {
    uiSelectDevice = true;
  }

  @action
  void setProps(ControllerProperties props) {
    this.props = props;
  }

  @action
  void addExecutable(String exec) {
    props?.updateItem(
        exec,
        (value) => Property(
            name: "executable", type: PropertyType.string, value: exec));
  }
}
