import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';

class MessageListTile extends StatelessWidget {
  const MessageListTile({
    super.key,
    required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final isSentByYou =
        context.read<ChatBloc>().sender.id == messageModel.sentBy;

    return Container(
      decoration: BoxDecoration(
        color: isSentByYou
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            messageModel.text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSentByYou
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
          ),
          Text(
            messageModel.sentAt.toIso8601String(),
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
