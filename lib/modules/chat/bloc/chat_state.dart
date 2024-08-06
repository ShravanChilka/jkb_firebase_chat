part of 'chat_bloc.dart';

class ChatState {
  const ChatState({
    required this.isLoading,
    required this.receiver,
    this.messages = const [],
  });

  final bool isLoading;
  final UserModel receiver;
  final List<MessageModel> messages;

  ChatState copyWith({
    bool? isLoading,
    UserModel? receiver,
    List<MessageModel>? messages,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      receiver: receiver ?? this.receiver,
      messages: messages ?? this.messages,
    );
  }
}
