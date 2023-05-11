import 'package:flame/components.dart';
import 'package:flame_socketio/src/flame_socketio_client.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// Add [IO.Socket] access and listening to a [Component]
///  from an existing Socket connection instantiated by [FlameSocketIOClient]
mixin HasSocketIOClient on Component {
  late IO.Socket _socket;

  /// Get the socket event handler of this component, once it has been mounted
  IO.Socket get socket {
    assert(
      isMounted,
      'Cannot access the bloc instance before it has been mounted.',
    );
    return _socket;
  }

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();
    final socketParents = ancestors().whereType<FlameSocketIOClient>();
    assert(
      socketParents.isNotEmpty,
      'SocketIO Components can only be added as child of '
      'SocketIO client or SocketIO server components',
    );
    _socket = socketParents.first.socket as IO.Socket;
  }

  @override
  @mustCallSuper
  void onRemove() {
    super.onRemove();
    socket.disconnect();
  }
}
