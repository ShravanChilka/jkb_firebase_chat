import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/recent_chats/bloc/recent_chats_bloc.dart';
import 'recent_chats_screen.dart';

class RecentChatsPage extends StatelessWidget {
  const RecentChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentChatsBloc(),
      child: const RecentChatsScreen(),
    );
  }
}
