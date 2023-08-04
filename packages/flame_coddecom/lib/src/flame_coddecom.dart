import 'package:codde_com/codde_com.dart';
import 'package:flame/components.dart';

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

  /* @override
  FutureOr<void> onLoad() {
    super.onLoad();
    com.connect(); // let user connect itself
  } */

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
