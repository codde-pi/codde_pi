import 'dart:async';

import 'package:codde_com/codde_com.dart';
import 'package:flame/components.dart';

/// socket client [Component], establishing connection
/// once initialized
class FlameCoddeCom extends Component {
  CoddeProtocol protocol;
  Map builder;
  dynamic options;
  CoddeCom com;

  /// Constructor of socket client [Component]
  FlameCoddeCom(this.protocol, this.builder)
      : com = CoddeCom(protocol, builder);

  /* (options as Map).map<dynamic, dynamic>(
            (dynamic key, dynamic value) => (key == 'autoConnect')
                ? MapEntry<dynamic, dynamic>(key, false)
                : MapEntry<dynamic, dynamic>(key, value),), */

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    com.connect(); // TODO: let user connect itself
  }

  /* /// Callback when connection has been established with specified server socket
  void onConnect(Function(dynamic) connect) {
    com.onConnect(connect);
  }

  /// Callback when client disconnect to the specified server socket
  void onDisconnect(Function(dynamic) disconnect) {
    com.onDisconnect(disconnect);
  } */

  @override
  void onRemove() {
    super.onRemove();
    com.disconnect();
  }
}
