import 'dart:async';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:xterm/xterm.dart';

part 'codde_state.g.dart';

class CoddeState = _CoddeState with _$CoddeState;

abstract class _CoddeState with Store {
  @observable
  Project project;

  _CoddeState(this.project);

  @action
  void selectDevice(Device device) {
    project.device = device;
  }
}
