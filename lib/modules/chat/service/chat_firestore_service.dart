import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/chat_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/recent_chat_model.dart';

class ChatFirestoreService {
  final _client = FirebaseFirestore.instance;

  Future<String> createChat({
    required UserModel sender,
    required UserModel receiver,
  }) async {
    final chatId = _getChatId(sender: sender, receiver: receiver);
    final ref = _client.collection('chats').doc(chatId);
    final isChatCreated = await ref.get().then((doc) => doc.exists);
    if (isChatCreated) return chatId;
    final model = ChatModel(
      id: chatId,
      createdAt: DateTime.now(),
      createdBy: sender.id,
    );
    await ref.set(model.toMap());
    // create recent chat for both users
    await createRecentChat(user: sender, chatId: chatId);
    await createRecentChat(user: receiver, chatId: chatId);
    return chatId;
  }

  String _getChatId({
    required UserModel sender,
    required UserModel receiver,
  }) {
    final senderId = sender.id;
    final receiverId = receiver.id;
    return receiverId.compareTo(senderId) > 0
        ? '${receiverId}_$senderId'
        : '${senderId}_$receiverId';
  }

  Future<void> sendMessage({
    required MessageModel message,
    required String chatId,
  }) async {
    final ref =
        _client.collection('chats').doc(chatId).collection('messages').doc();
    final model = message.copyWith(id: ref.id);
    return await ref.set(model.toMap());
  }

  Future<List<MessageModel>> getMessages({
    required String chatId,
  }) async {
    final ref =
        _client.collection('chats').doc(chatId).collection('messages').where(
              'sentAt',
              isLessThan: DateTime.now().millisecondsSinceEpoch,
            );
    final response = await ref.get();
    final docs = response.docs;
    return docs.map((doc) => MessageModel.fromMap(doc.data())).toList();
  }

  Future<void> createRecentChat({
    required UserModel user,
    required String chatId,
  }) async {
    final ref = _client
        .collection('users')
        .doc(user.id)
        .collection('recentMessages')
        .doc(chatId);
    final model = RecentChatModel(chatId: chatId);
    return await ref.set(model.toMap());
  }
}
