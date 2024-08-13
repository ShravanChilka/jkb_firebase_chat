import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jkb_firebase_chat/modules/auth/service/auth_firebase_service.dart';
import 'package:jkb_firebase_chat/modules/chat/view/chat_page.dart';
import 'package:jkb_firebase_chat/modules/recent_chats/bloc/recent_chats_bloc.dart';

class RecentChatsScreen extends StatelessWidget {
  const RecentChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreListView.separated(
      query: context.read<RecentChatsBloc>().getRecentChatQuery(),
      itemBuilder: (context, doc) {
        final recentChat = doc.data();
        return StreamBuilder(
          stream: context.read<RecentChatsBloc>().getRecentChatMessageStream(
                recentChat,
              ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recentChatMessage = snapshot.requireData;
              return ListTile(
                trailing: Text(
                  DateFormat('hh:mm aa')
                      .format(recentChatMessage.message.sentAt),
                ),
                leading: CircleAvatar(
                  child: Center(
                    child: Text(
                      _getFirstCharacter(recentChatMessage.user.email),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                onTap: () {
                  final receiver = recentChatMessage.user;
                  final sender = AuthFirebaseService().currentUser!;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatPage(sender: sender, receiver: receiver),
                    ),
                  );
                },
                title: Text(recentChatMessage.user.email ?? '-'),
                subtitle: Text(recentChatMessage.text),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
    );
  }

  String _getFirstCharacter(String? email) {
    final firstChar = email?.characters.firstOrNull;
    return firstChar?.toUpperCase() ?? '#';
  }
}
