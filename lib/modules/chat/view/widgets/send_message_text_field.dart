import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/view/widgets/send_message_button.dart';

class SendMessageTextField extends StatefulWidget {
  const SendMessageTextField({super.key});

  @override
  State<SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<SendMessageTextField> {
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    final bloc = context.read<ChatBloc>();
    bloc.messageController = messageController;
  }

  late final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: SendMessageButton(
            onPressed: () {
              context.read<ChatBloc>().add(
                    ChatEventSendMessage(
                      message: messageController.text,
                    ),
                  );
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
