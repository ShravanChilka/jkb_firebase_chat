import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';

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
  }

  final UserModel sender;
  final UserModel receiver;

  FutureOr<void> _onChatEventInitialize(
    ChatEventInitialize event,
    Emitter<ChatState> emit,
  ) {}
}
