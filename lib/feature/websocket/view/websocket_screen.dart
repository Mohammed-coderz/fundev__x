import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/websocket_cubit.dart';
import '../state/websocket_state.dart';

class WebSocketScreen extends StatelessWidget {
  const WebSocketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebSocketCubit()..connect(),
      child: const WebSocketView(),
    );
  }
}

class WebSocketView extends StatefulWidget {
  const WebSocketView({super.key});

  @override
  State<WebSocketView> createState() => _WebSocketViewState();
}

class _WebSocketViewState extends State<WebSocketView> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = messageController.text.trim();

    if (message.isEmpty) return;

    context.read<WebSocketCubit>().sendMessage(message);
    messageController.clear();
  }

  List<String> getMessages(WebSocketState state) {
    if (state is WebSocketConnectedState) {
      print(state.messages);
      return state.messages;
    }

    return [];
  }

  bool isConnected(WebSocketState state) {
    return state is WebSocketConnectedState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Cubit'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WebSocketCubit>().clearMessages();
            },
            icon: const Icon(Icons.delete_outline),
          ),
          IconButton(
            onPressed: () {
              context.read<WebSocketCubit>().connect();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WebSocketCubit, WebSocketState>(
        builder: (context, state) {
          final messages = getMessages(state);

          return Column(
            children: [
              _ConnectionStatusCard(state: state),

              if (state is WebSocketConnectingState)
                const LinearProgressIndicator(),

              if (state is WebSocketErrorState)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              Expanded(
                child: messages.isEmpty
                    ? const Center(
                  child: Text(
                    'No messages yet',
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            messages[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              _MessageInput(
                controller: messageController,
                onSend: sendMessage,
                isConnected: isConnected(state),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ConnectionStatusCard extends StatelessWidget {
  final WebSocketState state;

  const _ConnectionStatusCard({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    IconData icon;

    if (state is WebSocketInitialState) {
      color = Colors.grey;
      text = 'Initial';
      icon = Icons.circle_outlined;
    }
    else if (state is WebSocketConnectingState) {
      color = Colors.orange;
      text = 'Connecting...';
      icon = Icons.sync;
    }
    else if (state is WebSocketConnectedState) {
      color = Colors.green;
      text = 'Connected';
      icon = Icons.check_circle;
    }
    else if (state is WebSocketDisconnectedState) {
      color = Colors.red;
      text = 'Disconnected';
      icon = Icons.cancel;
    }
    else if (state is WebSocketErrorState) {
      color = Colors.red;
      text = 'Error';
      icon = Icons.error;
    }
    else {
      color = Colors.grey;
      text = 'Unknown';
      icon = Icons.help_outline;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isConnected;

  const _MessageInput({
    required this.controller,
    required this.onSend,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: isConnected,
                decoration: const InputDecoration(
                  hintText: 'Write message...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isConnected ? onSend : null,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}