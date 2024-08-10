import 'package:flutter/material.dart';
import 'package:jkb_firebase_chat/modules/search_user/view/search_user_delegate.dart';
import 'package:jkb_firebase_chat/modules/settings/view/settings_screen.dart';

import '../../recent_chats/view/recent_chats_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchUserDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
      body: const RecentChatsPage(),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.update_sharp),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}
