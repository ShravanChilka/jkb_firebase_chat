import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/shared/full_screen_loader.dart';

import 'widgets/messages_list_view.dart';
import 'widgets/send_message_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ChatBloc>().add(const ChatEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return FullScreenLoader(
          isLoading: state.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.receiver.email ?? '-'),
            ),
            body: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MessagesListView(),
                ),
                SendMessageTextField(),
              ],
            ),
          ),
        );
      },
    );
  }
}
