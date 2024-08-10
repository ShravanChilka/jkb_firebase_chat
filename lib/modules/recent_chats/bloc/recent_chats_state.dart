part of 'recent_chats_bloc.dart';

class RecentChatsState {
  final List<RecentChatMessageModel> chats;
  const RecentChatsState({
    required this.chats,
  });

  RecentChatsState copyWith({
    List<RecentChatMessageModel>? chats,
  }) {
    return RecentChatsState(
      chats: chats ?? this.chats,
    );
  }
}
