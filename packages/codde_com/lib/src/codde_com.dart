import 'package:codde_com/codde_com.dart';
import 'package:codde_com/src/api/com_common.dart';
import 'package:codde_com/src/api/com_socket.dart';

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
  }

  ProtocolBuilder builder;
  late dynamic com;
  late ProtocolTranscriber trans;

  @override
  void connect() {
    com.connect();
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
  }
}

enum CoddeProtocol { socket, socketio, usb, bluetooth, http }

class UnsupportedCoddeProtocol implements Exception {}
