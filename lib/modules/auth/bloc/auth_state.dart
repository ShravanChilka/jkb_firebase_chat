part of 'auth_bloc.dart';

class AuthState {
  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
  });

  final bool isLoading;
  final bool isAuthenticated;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
