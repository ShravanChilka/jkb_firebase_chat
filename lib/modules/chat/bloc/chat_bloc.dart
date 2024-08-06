import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';
import 'package:jkb_firebase_chat/modules/chat/service/chat_firestore_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.sender,
    required this.receiver,
  }) : super(
          ChatState(isLoading: false, receiver: receiver),
        ) {
    on<ChatEventInitialize>(_onChatEventInitialize);
    on<ChatEventSendMessage>(_onChatEventSendMessage);
  }

  final UserModel sender;
  final UserModel receiver;

  final _service = ChatFirestoreService();

  TextEditingController? messageController;

  late final String _chatId;

  FutureOr<void> _onChatEventInitialize(
    ChatEventInitialize event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    _chatId = await _service.createChat(
      sender: sender,
      receiver: receiver,
    );
    final messages = await _service.getMessages(
      chatId: _chatId,
    );
    emit(
      state.copyWith(
        isLoading: false,
        messages: messages,
      ),
    );
  }

  FutureOr<void> _onChatEventSendMessage(
    ChatEventSendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final model = MessageModel(
      id: '',
      text: event.message,
      type: MessageType.text,
      sentAt: DateTime.now(),
      sentBy: sender.id,
    );
    await _service.sendMessage(
      message: model,
      chatId: _chatId,
    );
    messageController?.clear();
  }
}
