import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/service/auth_firebase_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/utils/firestore_collections.dart';
import '../../auth/email_auth/model/user_model.dart';
import '../../chat/model/message_model.dart';
import '../../chat/model/recent_chat_model.dart';
import '../model/recent_chat_message_model.dart';

part 'recent_chats_event.dart';
part 'recent_chats_state.dart';

class RecentChatsBloc extends Bloc<RecentChatsEvent, RecentChatsState> {
  RecentChatsBloc() : super(const RecentChatsState(chats: [])) {
    on<RecentChatEventInitalize>(_onRecentChatEventInitalize);
  }

  FutureOr<void> _onRecentChatEventInitalize(
    RecentChatEventInitalize event,
    Emitter<RecentChatsState> emit,
  ) {}

  CollectionReference<RecentChatModel> getRecentChatQuery() {
    return FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .doc(AuthFirebaseService().currentUser!.id)
        .collection(FirestoreCollections.recentChats)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              RecentChatModel.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  Stream<RecentChatMessageModel> getRecentChatMessageStream(
    RecentChatModel recentChat,
  ) {
    final chatId = recentChat.chatId;
    final senderUserId = _extractSenderUserId(
      chatId: recentChat.chatId,
      currentUserId: AuthFirebaseService().currentUser!.id,
    );
    final messageStream = _getMessageStream(chatId);
    final userStream = _getUserStream(senderUserId);
    return Rx.combineLatest2(
      userStream,
      messageStream,
      (userModel, messageModel) {
        return RecentChatMessageModel(
          user: userModel,
          message: messageModel,
        );
      },
    );
  }

  String _extractSenderUserId({
    required String chatId,
    required String currentUserId,
  }) {
    final splitList = chatId.split('_');
    return splitList.firstWhere(
      (item) => item != currentUserId,
      orElse: () => currentUserId,
    );
  }

  Stream<MessageModel> _getMessageStream(String chatId) {
    return FirebaseFirestore.instance
        .collection(FirestoreCollections.chats)
        .doc(chatId)
        .collection(FirestoreCollections.messages)
        .limit(1)
        .orderBy(
          'sentAt',
          descending: true,
        )
        .snapshots()
        .map(
          (query) =>
              query.docs.map((doc) => MessageModel.fromMap(doc.data())).first,
        );
  }

  Stream<UserModel> _getUserStream(String senderUserId) {
    return FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .doc(senderUserId)
        .snapshots()
        .map(
          (doc) => UserModel.fromMap(doc.data()!),
        );
  }
}
