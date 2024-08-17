import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/view/chat_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.sender,
    required this.receiver,
  });

  final UserModel sender;
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        sender: sender,
        receiver: receiver,
      ),
      child: const ChatScreen(),
    );
  }
}
