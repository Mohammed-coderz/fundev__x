abstract class WebSocketState {}

class WebSocketInitialState extends WebSocketState {}

class WebSocketConnectingState extends WebSocketState {}

class WebSocketConnectedState extends WebSocketState {
  final List<String> messages;

  WebSocketConnectedState({required this.messages});
}

class WebSocketDisconnectedState extends WebSocketState {}

class WebSocketErrorState extends WebSocketState {
  final String message;

  WebSocketErrorState({required this.message});
}
