import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/view/widgets/message_list_tile.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final messages = state.messages;
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return MessageListTile(
              messageModel: messages[index],
            );
          },
        );
      },
    );
  }
}
