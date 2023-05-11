class ProtocolBuilder {
  final Map<String, dynamic> _opts;
  ProtocolBuilder() : _opts = <String, dynamic>{};

  Map useSocketIO(String uri, opts) {
    _opts['uri'] = uri;
    _opts['opts'] = opts;
    return _opts;
  }

  Map useUSB(String device) {
    _opts["device"] = device;
    return _opts;
  }

  Map useSocket(String address, int port) {
    _opts['address'] = address;
    _opts['port'] = port;
    return _opts;
  }

  Map<String, dynamic> build() => _opts;
}
