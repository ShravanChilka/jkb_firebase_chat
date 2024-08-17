import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/model/message_model.dart';

class RecentChatMessageModel {
  final UserModel user;
  final MessageModel message;
  const RecentChatMessageModel({
    required this.user,
    required this.message,
  });

  String get text {
    if (message.type == MessageType.image) return '🌄 Sent an image';
    return message.text;
  }
}
