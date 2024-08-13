import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/view/widgets/send_message_button.dart';

import 'pick_image_icon_button.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Row(
        children: [
          const PickImageIconButton(),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 4),
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
