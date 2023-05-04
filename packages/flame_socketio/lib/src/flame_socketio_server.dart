/* import 'package:flame/components.dart';
import 'package:socket_io/socket_io.dart';

/// {@template flame_socketio_server}
/// A [Component] that open http server and expose it to its children
/// {@endtemplate}
class FlameSocketIOServer extends Component {
  dynamic? server;
  Map? options;
  int? port;
  late Server io;

  /// Server Component constructor.
  ///
  /// @param {http.Server|Number|Object} http server, port or options
  /// @param {Object} options
  /// @api public
  FlameSocketIOServer({this.server = 3000, this.options})
      : io = Server(server: server, options: options);

  @override
  void onLoad() {
    super.onLoad();
    io.listen(server);
  }

  @override
  void onRemove() {
    super.onRemove();
    io.close();
  }
} */
