import 'package:codde_com/src/api/com_common.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ComSocket implements ComCommon {
  final uri;
  final Map options;
  late final Socket socket;

  ComSocket.fromMap(Map map)
      : assert(map.containsKey('uri'), 'No URI provided'),
        uri = map['uri'],
        options = map.containsKey('opts') ? map['opts'] : {} {
    options['autoConnect'] = false;
    socket = io(uri, options);
  }

  @override
  void connect() {
    socket.connect();
  }

  @override
  void disconnect() {
    socket.disconnect();
    socket.dispose();
  }

  @override
  void send(String event, [dynamic data]) {
    socket.emit(event, data);
  }

  @override
  void on(String event, Function handler) {
    // TODO: implement on
  }
}
