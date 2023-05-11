/* import 'package:flame/components.dart';
import 'package:flame_socketio/src/flame_socketio_server.dart';
import 'package:meta/meta.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io/src/namespace.dart';

/// {@template flame_socketio_namespace}
/// A [Component] that access to [Server] ancestors instance
/// and define derived Namespace to listen on new [Socket] events
///
/// Namespace instance can handle multiple socket event under his name
/// {@endtemplate}
class FlameSocketIONamespace extends Component {
  late Server _io;
  late Namespace _nsp;
  String? _namespace;

  /// Namespace Component constructor.
  ///
  /// @param {String|Namespace} server namespace or string name
  FlameSocketIONamespace({dynamic namespace = '/'}) {
    assert(
      namespace is Namespace || namespace is String,
      'Invalid parameter type',
    );
    if (namespace is Namespace) {
      nsp = nsp;
    } else if (nsp is String) {
      _namespace = namespace as String;
    }
  }

  /// Get defined Namespace for this Component.
  ///  Default is Server root.
  Namespace get nsp {
    assert(isLoaded,
        'Cannot access the Server instance before it has been loaded.');
    return _nsp;
  }

  /// Place Component under the given [Namespace] value
  set nsp(Namespace value) {
    _nsp = value;
  }

  /// Get [Server] active instance from components ancestors
  Server get io {
    assert(
        isLoaded, 'Cannot access the bloc instance before it has been loaded.');
    return _io;
  }

  @override
  @mustCallSuper
  void onLoad() {
    super.onLoad();
    if (_namespace != null) {
      final socketParents = ancestors().whereType<FlameSocketIOServer>();
      assert(
        socketParents.isNotEmpty,
        'SocketIO Components can only be added as child of '
        'SocketIO client or SocketIO server components',
      );
      _io = socketParents.first.io as Server;
      nsp = io.of(_namespace);
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    nsp.sockets.toList().forEach((element) {
      element.onclose();
    });
    nsp.clearListeners();
  }
} */
