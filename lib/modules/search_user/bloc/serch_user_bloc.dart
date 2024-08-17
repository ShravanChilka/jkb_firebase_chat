import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/search_user/service/search_user_firestore_service.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(const SearchUserState(isLoading: false, users: [])) {
    on<SearchUserEventQueryChanged>(_onSearchUserEventQueryChanged);
  }

  final _service = SearchUserFirestoreService();

  FutureOr<void> _onSearchUserEventQueryChanged(
    SearchUserEventQueryChanged event,
    Emitter<SearchUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _service.searchUser(query: event.query);
    response.fold(
      (l) {},
      (r) {
        emit(state.copyWith(isLoading: false, users: r));
      },
    );
  }
}
