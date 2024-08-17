part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState {
  const PhoneAuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
  });

  final bool isLoading;
  final bool isAuthenticated;
}

class PhoneAuthStateInital extends PhoneAuthState {
  const PhoneAuthStateInital({
    super.isAuthenticated,
    super.isLoading,
  });
}

class PhoneAuthStateCodeSent extends PhoneAuthState {
  const PhoneAuthStateCodeSent({
    required this.verificationId,
    this.resendToken,
    super.isAuthenticated,
    super.isLoading,
  });

  final String verificationId;
  final int? resendToken;
}

class PhoneAuthStateCodeVerified extends PhoneAuthState {
  const PhoneAuthStateCodeVerified({
    super.isAuthenticated = true,
    super.isLoading = false,
  });
}
