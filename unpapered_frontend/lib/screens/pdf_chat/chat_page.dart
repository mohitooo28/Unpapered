import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:svg_flutter/svg.dart';
import 'package:unpapered/screens/pdf_chat/chat_manager.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatManager chatManager = ChatManager();
  late StreamSubscription _streamSubscription;
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    super.initState();
    chatManager.initializeWebsocket();
    _streamSubscription = chatManager.channel.stream.listen(
      (event) {
        chatManager.onMessageReceived(event);
        setState(() {});
      },
      onError: (error) {
        print('WebSocket error: $error');
        chatManager.closeWebSocket();
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    chatManager.closeWebSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDEDED),
        surfaceTintColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF043A50),
              size: 22,
            )),
        title: Center(
          child: Text(
            'Unpapered',
            style: GoogleFonts.museoModerno(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF043A50)),
          ),
        ),
        //----------------------
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ShakeMe(
              key: shakeKey,
              shakeCount: 3,
              shakeOffset: 3,
              shakeDuration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  shakeKey.currentState?.shake();
                },
                child: SvgPicture.asset(
                  'assets/logos/logo.svg',
                  width: 32,
                  height: 35,
                ),
              ),
            ),
          )
        ],
        //----------------------
      ),
      body: Chat(
        messages: chatManager.messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: false,
        showUserNames: false,
        user: chatManager.user,
        disableImageGallery: true,
        scrollPhysics: const BouncingScrollPhysics(),
        theme: DefaultChatTheme(
          backgroundColor: const Color(0xFFEDEDED),
          inputBorderRadius: BorderRadius.zero,
          inputTextStyle: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          dateDividerTextStyle: const TextStyle(color: Colors.transparent),
          receivedMessageBodyBoldTextStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          receivedMessageBodyTextStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          sentMessageBodyTextStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          sentMessageBodyBoldTextStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          userNameTextStyle: const TextStyle(color: Colors.white),
          primaryColor: const Color(0xFFBD6600),
          secondaryColor: const Color(0xFF04709B),
          inputTextCursorColor: Colors.white,
          inputBackgroundColor: const Color(0xFF00141C),
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    if (!chatManager.isLoading) {
      final textMessage = types.TextMessage(
        author: chatManager.user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );
      chatManager.addMessage(textMessage);
      setState(() {});
    }
  }
}
