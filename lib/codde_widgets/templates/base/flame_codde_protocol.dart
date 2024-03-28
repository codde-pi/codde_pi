part of '../../codde_widgets.dart';

/// socket client [Component], establishing connection
/// once initialized
class FlameCoddeProtocol extends Component {
  CoddeCom com;
  String address;
  Protocol protocol;

  /// Constructor of [CoddeCom] [Component]
  FlameCoddeProtocol({required this.protocol, required this.address})
      : com = CoddeCom(protocol: protocol, addr: address);

  FlameCoddeProtocol.fromInstance({required this.com})
      : address = com.addr,
        protocol = com.protocol;

  // FlameCoddeProtocol.dummy() : com = null;

  // TODO: add state listener to implement onConnect / onDisconnect
  /* @override
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
  } */

  @override
  void onRemove() {
    super.onRemove();
    com.disconnect();
  }
}
