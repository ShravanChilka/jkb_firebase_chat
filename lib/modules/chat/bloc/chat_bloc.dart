import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';
import 'package:jkb_firebase_chat/modules/chat/service/chat_firestore_service.dart';
import 'package:jkb_firebase_chat/modules/chat/service/chat_storage_service.dart';

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
    on<ChatEventSendImage>(_onChatEventSendImage);
  }

  final UserModel sender;
  final UserModel receiver;

  final _service = ChatFirestoreService();
  final _storageService = ChatStorageService();

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
    final messages = _service.getMessages(
      chatId: _chatId,
    );
    return emit.forEach(messages, onData: (data) {
      return state.copyWith(
        isLoading: false,
        messages: data,
      );
    });
  }

  FutureOr<void> _onChatEventSendMessage(
    ChatEventSendMessage event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
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
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onChatEventSendImage(
    ChatEventSendImage event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final imageUrl = await _storageService.uploadFile(
      chatId: _chatId,
      filePath: event.path,
    );
    final model = MessageModel(
      id: '',
      text: imageUrl,
      type: MessageType.image,
      sentAt: DateTime.now(),
      sentBy: sender.id,
    );
    await _service.sendMessage(
      message: model,
      chatId: _chatId,
    );
    emit(state.copyWith(isLoading: false));
  }
}
