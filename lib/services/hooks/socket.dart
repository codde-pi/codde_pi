import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

IO.Socket useSocketIO({required String uri, required String port, optionBuilder}) {
  final socket = useMemoized(() => IO.io('http://$uri:$port', optionBuilder));

  return socket;
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
