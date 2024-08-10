// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';

class RecentChatMessageModel {
  final UserModel user;
  final MessageModel message;
  const RecentChatMessageModel({
    required this.user,
    required this.message,
  });
}
