import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';
import 'package:jkb_firebase_chat/modules/auth/service/auth_firebase_service.dart';
import 'package:jkb_firebase_chat/modules/auth/service/auth_firestore_service.dart';

import '../../../shared/show_snack_bar.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const AuthState(
            isLoading: false,
            isAuthenticated: false,
          ),
        ) {
    on<AuthEventInitialize>(_onAuthEventInitialize);
    on<AuthEventCreateAccount>(_onAuthEventCreateAccount);
    on<AuthEventLogin>(_onAuthEventLogin);
    on<AuthEventLogOut>(_onAuthEventLogOut);
    on<_AuthEventCreateUser>(_onAuthEventCreateUser);
  }

  final _authService = AuthFirebaseService();
  final _firestoreService = AuthFirestoreService();

  FutureOr<void> _onAuthEventInitialize(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) {
    final response = _authService.isAuthenticated;
    return emit.forEach(response, onData: (isAuthenticated) {
      return state.copyWith(
        isAuthenticated: isAuthenticated,
        currentUser: _authService.currentUser,
      );
    });
  }

  FutureOr<void> _onAuthEventCreateAccount(
    AuthEventCreateAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.createAccount(
      emailAddress: event.emailAddress,
      password: event.password,
    );
    response.fold(
      (l) {
        showSnackbar(l);
        emit(
          state.copyWith(isLoading: false, isAuthenticated: false),
        );
      },
      (r) {
        add(
          _AuthEventCreateUser(
            userModel: UserModel(
              id: r.user?.uid ?? '',
              email: r.user?.email,
              name: r.user?.displayName,
            ),
          ),
        );

        showSnackbar('Account created!');
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            currentUser: _authService.currentUser,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAuthEventLogin(
    AuthEventLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.login(
      emailAddress: event.emailAddress,
      password: event.password,
    );
    response.fold(
      (l) {
        showSnackbar(l);
        emit(
          state.copyWith(isLoading: false, isAuthenticated: false),
        );
      },
      (r) {
        showSnackbar('Login successful!');
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            currentUser: _authService.currentUser,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAuthEventLogOut(
    AuthEventLogOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.logout();
    response.fold(
      (l) {
        showSnackbar(l);
      },
      (r) {
        showSnackbar('LogOut successful!');
        emit(
          state.copyWith(isLoading: false, isAuthenticated: false),
        );
      },
    );
  }

  FutureOr<void> _onAuthEventCreateUser(
    _AuthEventCreateUser event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _firestoreService.createUser(
      userModel: event.userModel,
    );
    log(response.toString());
  }
}
