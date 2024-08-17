import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthService {
  final _client = FirebaseAuth.instance;

  void sendCode({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(
      FirebaseAuthException e,
    ) onVerificationFailed,
    required void Function(
      PhoneAuthCredential credential,
    ) onVerificationComplete,
  }) async {
    await _client.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationComplete,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {
        onCodeSent.call(verificationId, null);
      },
    );
  }

  Future<Either<String, UserCredential>> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return right(
        await _client.signInWithCredential(credential),
      );
    } catch (e) {
      return left('Something went wrong!');
    }
  }
}
