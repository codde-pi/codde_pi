import 'package:codde_pi/services/db/database.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:mobx/mobx.dart';

part 'controlled_device_form_store.g.dart';

class ControlledDeviceFormStore = _ControlledDeviceFormStore
    with _$ControlledDeviceFormStore;

abstract class _ControlledDeviceFormStore with Store {
  @observable
  bool pswdObscured = true;

  @action
  toggleObscurePswd() {
    pswdObscured = !pswdObscured;
  }

  @observable
  Protocol protocolController = Protocol.webSocket;
  @action
  setProtocol(Protocol protocol) {
    protocolController = protocol;
  }

  @observable
  DeviceModel modelController = DeviceModel.sbc;
  @action
  setModel(DeviceModel model) {
    modelController = model;
  }

  // errors
  @observable
  bool hostRequiredError = false;
  @action
  raiseHostRequiredError() {
    hostRequiredError = true;
  }
}
