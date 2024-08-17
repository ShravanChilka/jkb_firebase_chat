import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/chat/view/chat_page.dart';

import '../../../auth/email_auth/bloc/auth_bloc.dart';
import '../search_user_delegate.dart';

class SearchUserIconButton extends StatelessWidget {
  const SearchUserIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch<UserModel>(
          context: context,
          delegate: SearchUserDelegate(),
        ).then(
          (userModel) {
            if (userModel == null) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  sender: context.read<AuthBloc>().state.currentUser!,
                  receiver: userModel,
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
