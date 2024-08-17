import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/phone_auth/service/phone_auth_service.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc() : super(const PhoneAuthStateInital()) {
    on<PhoneAuthEventSendCode>(_onPhoneAuthEventSendCode);
    on<PhoneAuthEventVerifyCode>(_onPhoneAuthEventVerifyCode);
    on<PhoneAuthEventResendCode>(_onPhoneAuthEventResendCode);
    on<_PhoneAuthEventCodeSent>(_onPhoneAuthEventCodeSent);
    on<_PhoneAuthEventCodeVerified>(_onPhoneAuthEventCodeVerified);
  }

  final _service = PhoneAuthService();

  FutureOr<void> _onPhoneAuthEventSendCode(
    PhoneAuthEventSendCode event,
    Emitter<PhoneAuthState> emit,
  ) {
    _service.sendCode(
      phoneNumber: event.phoneNumber,
      onCodeSent: (verificationId, resendToken) {
        add(
          _PhoneAuthEventCodeSent(
            verificationId: verificationId,
            resendToken: resendToken,
          ),
        );
      },
      onVerificationFailed: (e) {},
      onVerificationComplete: (credential) {
        add(const _PhoneAuthEventCodeVerified());
      },
    );
  }

  FutureOr<void> _onPhoneAuthEventVerifyCode(
    PhoneAuthEventVerifyCode event,
    Emitter<PhoneAuthState> emit,
  ) async {
    final currentState = state;
    final verificationId = currentState is PhoneAuthStateCodeSent
        ? currentState.verificationId
        : null;
    if (verificationId == null) return null;
    final response = await _service.verifyOtp(
      verificationId: verificationId,
      smsCode: event.code,
    );
    response.fold(
      (l) {},
      (r) {
        emit(const PhoneAuthStateCodeVerified());
      },
    );
  }

  FutureOr<void> _onPhoneAuthEventResendCode(
    PhoneAuthEventResendCode event,
    Emitter<PhoneAuthState> emit,
  ) {}

  FutureOr<void> _onPhoneAuthEventCodeSent(
    _PhoneAuthEventCodeSent event,
    Emitter<PhoneAuthState> emit,
  ) {
    emit(
      PhoneAuthStateCodeSent(
        verificationId: event.verificationId,
        resendToken: event.resendToken,
      ),
    );
  }

  FutureOr<void> _onPhoneAuthEventCodeVerified(
    _PhoneAuthEventCodeVerified event,
    Emitter<PhoneAuthState> emit,
  ) {
    emit(const PhoneAuthStateCodeVerified());
  }
}
