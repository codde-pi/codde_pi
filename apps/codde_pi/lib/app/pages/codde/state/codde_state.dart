import 'dart:async';
import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:xterm/xterm.dart';

part 'codde_state.g.dart';

class CoddeState = _CoddeState with _$CoddeState;

abstract class _CoddeState with Store {
  @observable
  Project project;

  @observable
  Terminal? terminal;
  @observable
  StreamSubscription? stdoutListener;
  @observable
  StreamSubscription? stderrListener;

  @action
  Future initSshTerminal(BuildContext context, CoddeBackend backend) async {
    logger.i("initialization");
    if (terminal != null) return;
    terminal =
        Terminal(maxLines: 100000, onBell: () => HapticFeedback.vibrate());

    if (backend.location != BackendLocation.server) {
      throw Exception("Bad backend location");
    }
    if (!backend.isRunning) throw ();
    backend.shell ??= await backend.client?.shell(
        pty: SSHPtyConfig(
            width: terminal!.viewWidth, height: terminal!.viewHeight));

    // terminal.buffer.clear();
    // terminal.buffer.setCursor(0, 0);

    terminal?.onTitleChange = (title) {
      // setState(() => this.title = title);
    };

    terminal?.onResize = (width, height, pixelWidth, pixelHeight) {
      backend.shell?.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal?.onOutput = (data) {
      backend.shell?.write(utf8.encode(data));
    };

    stdoutListener = backend.shell!.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal?.write);

    stderrListener = backend.shell!.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal?.write);
  }

  @action
  void closeTerminal() {
    logger.i("dispose");
    stderrListener?.cancel();
    stdoutListener?.cancel();
  }

  _CoddeState(this.project);

  @action
  void selectDevice(Device device) {
    project.device = device;
  }
}
