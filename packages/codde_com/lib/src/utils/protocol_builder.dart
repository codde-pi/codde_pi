import 'package:codde_com/codde_com.dart';

class ProtocolBuilder {
  final Map<String, dynamic> _opts;
  ProtocolBuilder() : _opts = <String, dynamic>{};

  ProtocolBuilder useSocketIO(String uri, opts) {
    _opts['protocol'] = CoddeProtocol.socketio;
    _opts['uri'] = uri; // TODO: turn to Uri object
    _opts['opts'] = opts;
    return this;
  }

  ProtocolBuilder useUSB(String device) {
    _opts['protocol'] = CoddeProtocol.usb;
    _opts["device"] = device;
    return this;
  }

  ProtocolBuilder useSocket(String address, int port) {
    _opts['protocol'] = CoddeProtocol.socket;
    _opts['address'] = address;
    _opts['port'] = port;
    return this;
  }

  Map<String, dynamic> build() => _opts;

  CoddeProtocol get protocol => _opts['protocol'];
}
