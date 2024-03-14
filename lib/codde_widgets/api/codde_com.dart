part of '../codde_widgets.dart';

class CoddeCom {
  CoddeCom({required this.protocol, required this.addr}) {
    switch (protocol) {
      case Protocol.socket:
        com = ComSocketClient(address: addr);
        break;
      default:
        throw UnsupportedCoddeProtocol();
    }
  }

  late ComSocketClient com; // TODO: replace by [ClientProtocol]
  Protocol protocol;
  String addr;

  void connect() {
    com.connect();
  }

  void send(int id, WidgetRegistry data) {
    com.send(data: Frame(id: id, data: data));
  }

  void disconnect() {
    com.disconnect();
  }

  Future<ResultFrame?> receive() {
    return com.receive();
  }

  Future<ResultFrame?> request(int id, WidgetRegistry data) {
    return com.request(data: Frame(id: id, data: data));
  }

  Future<bool> get connected async => await com.isConnected();
}

class UnsupportedCoddeProtocol implements Exception {}
