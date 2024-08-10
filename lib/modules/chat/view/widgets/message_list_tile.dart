import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

    return Row(
      mainAxisAlignment:
          isSentByYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(8),
              topRight: const Radius.circular(8),
              bottomLeft: isSentByYou ? const Radius.circular(8) : Radius.zero,
              bottomRight: isSentByYou ? Radius.zero : const Radius.circular(8),
            ),
            color: isSentByYou
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
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
                DateFormat('hh:mm aa').format(messageModel.sentAt),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ],
    );
  }
}
