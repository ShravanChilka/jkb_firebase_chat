// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jkb_firebase_chat/core/utils/firestore_collections.dart';
// import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';
// import 'package:jkb_firebase_chat/modules/auth/service/auth_firebase_service.dart';
// import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';
// import 'package:jkb_firebase_chat/modules/chat/model/recent_chat_model.dart';
// import 'package:jkb_firebase_chat/modules/recent_chats/model/recent_chat_message_model.dart';
// import 'package:rxdart/rxdart.dart';

// class RecentChatsFirestoreService {
//   final _client = FirebaseFirestore.instance;

//   final _authService = AuthFirebaseService();

//   getRecentMessages() {
//     final currentUserId = _authService.currentUser?.id;
//     if (currentUserId == null) return;

//     final recentChatsStream = _getRecentChatsRef(currentUserId)
//         .snapshots()
//         .map(
//           (query) => query.docs
//               .map(
//                 (doc) => RecentChatModel.fromMap(doc.data()),
//               )
//               .toList(),
//         )
//         .map((recentChats) {
//       recentChats.map((recentChat) {
//         final chatId = recentChat.chatId;
//         final senderUserId = _extractSenderUserId(
//           chatId: recentChat.chatId,
//           currentUserId: currentUserId,
//         );
//         final messageStream = _getMessageStream(chatId);
//         final userStream = _getUserStream(senderUserId);
//         return Rx.combineLatest2(
//           userStream,
//           messageStream,
//           (userModel, messageModel) {
//             return RecentChatMessageModel(
//               email: userModel.email,
//               name: userModel.name,
//               message: messageModel.text,
//               sentAt: messageModel.sentAt,
//             );
//           },
//         );
//       }).toList();
//     });
//   }

//   CollectionReference<Map<String, dynamic>> _getRecentChatsRef(
//     String currentUserId,
//   ) {
//     return _client
//         .collection(FirestoreCollections.users)
//         .doc(currentUserId)
//         .collection(FirestoreCollections.recentChats);
//   }

//   String _extractSenderUserId({
//     required String chatId,
//     required String currentUserId,
//   }) {
//     final splitList = chatId.split('_');
//     return splitList.firstWhere(
//       (item) => item != currentUserId,
//     );
//   }

//   Stream<MessageModel> _getMessageStream(String chatId) {
//     return _client
//         .collection(FirestoreCollections.chats)
//         .doc(chatId)
//         .collection(FirestoreCollections.messages)
//         .limit(1)
//         .orderBy(
//           'sentAt',
//           descending: true,
//         )
//         .snapshots()
//         .map(
//           (query) =>
//               query.docs.map((doc) => MessageModel.fromMap(doc.data())).first,
//         );
//   }

//   Stream<UserModel> _getUserStream(String senderUserId) {
//     return _client
//         .collection(FirestoreCollections.users)
//         .doc(senderUserId)
//         .snapshots()
//         .map(
//           (doc) => UserModel.fromMap(doc.data()!),
//         );
//   }
// }
