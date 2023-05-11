import 'dart:async';

import 'package:flame/components.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// socket client [Component], establishing connection
/// once initialized
class FlameSocketIOClient extends Component {
  String url;
  dynamic options;
  IO.Socket socket;

  /// Constructor of socket client [Component]
  FlameSocketIOClient(this.url, [this.options]) : socket = IO.io(url, options);

  /* (options as Map).map<dynamic, dynamic>(
            (dynamic key, dynamic value) => (key == 'autoConnect')
                ? MapEntry<dynamic, dynamic>(key, false)
                : MapEntry<dynamic, dynamic>(key, value),), */

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    if (socket.opts != null &&
        socket.opts!.containsKey('autoConnect') &&
        socket.opts!['autoConnect'] == false) {
      socket.connect();
    }
  }

  /// Callback when connection has been established with specified server socket
  void onConnect(Function(dynamic) connect) {
    socket.onConnect(connect);
  }

  /// Callback when client disconnect to the specified server socket
  void onDisconnect(Function(dynamic) disconnect) {
    socket.onDisconnect(disconnect);
  }

  @override
  void onRemove() {
    super.onRemove();
    socket.disconnect();
    socket.dispose();
  }
}
