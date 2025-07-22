import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:unpapered/utils/api_config.dart';

class ChatManager {
  List<types.Message> messages = [];
  final user = const types.User(
    id: 'user',
  );
  final bot = const types.User(id: 'model', firstName: 'Unpapered');
  bool isLoading = false;
  late WebSocketChannel channel;

  void initializeWebsocket() {
    channel = IOWebSocketChannel.connect(ApiConfig.wsUrl);
  }

  void addMessage(types.Message message) {
    if (message is types.TextMessage) {
      if (message.author == user) {
        messages.insert(0, message);
        isLoading = true;
        channel.sink.add(message.text);
      } else if (message.author == bot) {
        messages.insert(0, message);
        isLoading = false;
      }
    }
  }

  void onMessageReceived(response) {
    if (response == "<FIN>") {
      isLoading = false;
    } else {
      final botMessage = types.TextMessage(
        author: bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: response,
      );
      addMessage(botMessage);
    }
  }

  void closeWebSocket() {
    if (channel != null) {
      channel.sink.close();
    }
  }
}
