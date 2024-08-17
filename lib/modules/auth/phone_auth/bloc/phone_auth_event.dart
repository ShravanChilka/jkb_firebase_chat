part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent {
  const PhoneAuthEvent();
}

class PhoneAuthEventSendCode extends PhoneAuthEvent {
  const PhoneAuthEventSendCode({
    required this.phoneNumber,
  });

  final String phoneNumber;
}

class _PhoneAuthEventCodeSent extends PhoneAuthEvent {
  const _PhoneAuthEventCodeSent({
    required this.verificationId,
    this.resendToken,
  });

  final String verificationId;
  final int? resendToken;
}

class _PhoneAuthEventCodeVerified extends PhoneAuthEvent {
  const _PhoneAuthEventCodeVerified();
}

class PhoneAuthEventVerifyCode extends PhoneAuthEvent {
  const PhoneAuthEventVerifyCode({
    required this.verificationId,
    required this.code,
  });

  final String verificationId;
  final String code;
}

class PhoneAuthEventResendCode extends PhoneAuthEvent {
  const PhoneAuthEventResendCode({
    required this.resendToken,
  });

  final String resendToken;
}
