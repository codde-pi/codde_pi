part of '../codde_widgets.dart';

class CoddeCom {
  CoddeCom({required this.protocol, required this.addr}) {
    switch (protocol) {
      case Protocol.webSocket:
        com = ComSocketClient(address: addr);
        break;
      default:
        throw UnsupportedCoddeProtocol();
    }
  }

  late ComSocketClient com; // TODO: replace by [ClientProtocol]
  Protocol protocol;
  String addr;

  Future connect() {
    return com.connect();
  }

  Future send(int id, WidgetRegistry data) async {
    await com.send(data: Frame(id: id, data: data));
    await HapticFeedback.mediumImpact();
  }

  Future disconnect() {
    return com.disconnect();
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
