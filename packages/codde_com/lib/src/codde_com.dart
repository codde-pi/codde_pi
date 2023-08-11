import 'package:codde_com/codde_com.dart';
import 'package:codde_com/src/api/com_common.dart';
import 'package:codde_com/src/api/com_socket.dart';
import 'package:flutter/widgets.dart';

class CoddeCom implements ComCommon {
  CoddeCom({required this.builder}) {
    trans = ProtocolTranscriber(builder.protocol);
    switch (builder.protocol) {
      case CoddeProtocol.socketio:
        com = ComSocket.fromMap(builder.build());
        break;
      default:
        throw UnsupportedCoddeProtocol();
    }
    comState = ValueNotifier(CoddeComState.disconnected);
  }

  ProtocolBuilder builder;
  late dynamic com;
  late ProtocolTranscriber trans;
  late ValueNotifier comState;

  @override
  void connect() {
    com.connect();
    updateState(CoddeComState.connected);
  }

  @override
  void send(String event, dynamic packet) {
    Function.apply(com.send, trans.run(event, packet));
  }

  @override
  void on(String event, Function handler) {
    com.on(event, handler);
  }

  @override
  void disconnect() {
    com.disconnect();
    updateState(CoddeComState.disconnected);
  }

  void updateState(CoddeComState value) {
    comState.value = value;
  }
}

enum CoddeProtocol { socket, socketio, usb, bluetooth, http }

class UnsupportedCoddeProtocol implements Exception {}

enum CoddeComState { connected, disconnected }
