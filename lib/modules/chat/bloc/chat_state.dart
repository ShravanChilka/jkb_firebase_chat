part of 'chat_bloc.dart';

class ChatState {
  const ChatState({
    required this.isLoading,
    required this.receiver,
  });

  final bool isLoading;
  final UserModel receiver;

  ChatState copyWith({
    bool? isLoading,
    UserModel? receiver,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      receiver: receiver ?? this.receiver,
    );
  }
}
