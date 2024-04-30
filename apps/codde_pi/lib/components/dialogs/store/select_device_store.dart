import 'package:codde_pi/services/db/device.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'select_device_store.g.dart';

class SelectDeviceStore = _SelectDeviceStore with _$SelectDeviceStore;

abstract class _SelectDeviceStore with Store {
  @observable
  Device? selectedDevice;
  @observable
  bool noDeviceError = false;
  @observable
  bool noPathError = false;
  @observable
  bool hostConnected = false;

  @action
  void selectDevice(Device d) {
    selectedDevice = d;
  }

  @action
  void raiseNoDeviceError() {
    noDeviceError = true;
  }

  @action
  void raiseNoPathError() {
    noPathError = true;
  }

  @action
  void hostNowConnected() {
    hostConnected = true;
  }
}
