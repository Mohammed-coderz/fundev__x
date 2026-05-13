import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../state/websocket_state.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  WebSocketCubit() : super( WebSocketInitialState());

  WebSocketChannel? _channel;

  final List<String> _messages = [];

  void connect() {
    try {
      emit( WebSocketConnectingState());

      _channel = WebSocketChannel.connect(
        Uri.parse('wss://echo.websocket.org'),
      );

      emit(
        WebSocketConnectedState(
          messages: List.from(_messages),
        ),
      );

      _channel!.stream.listen(
            (data) {
              print("------------");
              print(data.toString());
              print("------------");

          _messages.add(data.toString());

          emit(
            WebSocketConnectedState(
              messages: List.from(_messages),
            ),
          );
        },
        onError: (error) {
          emit(
            WebSocketErrorState(
              message: error.toString(),
            ),
          );
        },
        onDone: () {
          emit( WebSocketDisconnectedState());
        },
      );
    } catch (e) {
      emit(
        WebSocketErrorState(
          message: e.toString(),
        ),
      );
    }
  }

  void sendMessage(String message) {
    final text = message.trim();

    if (text.isEmpty) return;

    if (_channel == null) {
      emit(
         WebSocketErrorState(
          message: 'WebSocket is not connected',
        ),
      );
      return;
    }

    _channel!.sink.add(text);
  }

  void clearMessages() {
    _messages.clear();

    emit(
      WebSocketConnectedState(
        messages: List.from(_messages),
      ),
    );
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;

    emit( WebSocketDisconnectedState());
  }


  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}