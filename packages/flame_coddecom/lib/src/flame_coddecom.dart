import 'package:codde_com/codde_com.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

/// socket client [Component], establishing connection
/// once initialized
class FlameCoddeCom extends Component {
  ProtocolBuilder builder;
  dynamic options;
  CoddeCom com;

  /// Constructor of [CoddeCom] [Component]
  FlameCoddeCom({required this.builder}) : com = CoddeCom(builder: builder);

  FlameCoddeCom.fromInstance({required this.com}) : builder = com.builder;

  /* (options as Map).map<dynamic, dynamic>(
            (dynamic key, dynamic value) => (key == 'autoConnect')
                ? MapEntry<dynamic, dynamic>(key, false)
                : MapEntry<dynamic, dynamic>(key, value),), */

  @override
  @mustCallSuper
  void onLoad() {
    super.onLoad();
    com.comState.addListener(() {
      if (com.comState.value == CoddeComState.connected) {
        onConnect();
      } else if (com.comState.value == CoddeComState.disconnected) {
        onDisconnect();
      }
    });
  }

  /// Callback when connection has been established with specified server socket
  void onConnect() {
    // Intentionally left empty
  }

  /// Callback when client disconnect to the specified server socket
  void onDisconnect() {
    // Intentionally left empty
  }

  @override
  void onRemove() {
    super.onRemove();
    com.disconnect();
  }
}
