abstract class ComCommon {
  void connect();

  void send(String event, dynamic packet);

  void on(String event, Function handler);

  void disconnect();

  bool get connected;
}
