import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:jkb_firebase_chat/modules/chat/view/chat_page.dart';
import 'package:jkb_firebase_chat/modules/search_user/bloc/serch_user_bloc.dart';

class SearchUserListBuilder extends StatelessWidget {
  const SearchUserListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUserBloc, SearchUserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];

            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      sender: context.read<AuthBloc>().state.currentUser!,
                      receiver: user,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                child: Center(
                  child: Text(
                    _getFirstCharacter(user.email),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              title: Text(user.email ?? '-'),
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
        );
      },
    );
  }

  String _getFirstCharacter(String? email) {
    final firstChar = email?.characters.firstOrNull;
    return firstChar?.toUpperCase() ?? '#';
  }
}
