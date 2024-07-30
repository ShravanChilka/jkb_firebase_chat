part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogin extends AuthEvent {
  const AuthEventLogin({
    required this.emailAddress,
    required this.password,
  });

  final String emailAddress;
  final String password;
}

class AuthEventCreateAccount extends AuthEvent {
  const AuthEventCreateAccount({
    required this.emailAddress,
    required this.password,
  });

  final String emailAddress;
  final String password;
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class _AuthEventCreateUser extends AuthEvent {
  const _AuthEventCreateUser({
    required this.userModel,
  });

  final UserModel userModel;
}
