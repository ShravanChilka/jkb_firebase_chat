import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.receiver.email ?? '-'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Center(
                    child: IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
