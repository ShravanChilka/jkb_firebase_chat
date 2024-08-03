part of 'auth_bloc.dart';

class AuthState {
  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.currentUser,
  });

  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? currentUser;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
