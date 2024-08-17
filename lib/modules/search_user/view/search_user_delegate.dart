import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/search_user/bloc/serch_user_bloc.dart';
import 'package:jkb_firebase_chat/modules/search_user/view/widgets/search_user_list_builder.dart';

class SearchUserDelegate extends SearchDelegate<UserModel> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Icon(Icons.search);
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SearchUserListBuilder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<SearchUserBloc>().add(
          SearchUserEventQueryChanged(query: query),
        );
    return const SearchUserListBuilder();
  }
}
