import 'package:codde_com/codde_com.dart';

class ProtocolTranscriber {
  CoddeProtocol protocol;

  ProtocolTranscriber(this.protocol);

  List run(String event, dynamic packet) {
    switch (protocol) {
      case CoddeProtocol.socketio:
        return socketIOPacket(event, packet);
      default:
        return socketIOPacket(event, packet);
    }
  }

  List socketIOPacket(event, packet) {
    return [event, packet];
  }
}
