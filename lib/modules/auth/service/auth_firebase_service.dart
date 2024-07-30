import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  final _client = FirebaseAuth.instance;

  Stream<bool> get isAuthenticated {
    return _client.authStateChanges().map((user) => user != null);
  }

  Future<Either<String, UserCredential>> createAccount({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final response = await _client.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Something went wrong!');
    }
  }

  Future<Either<String, UserCredential>> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final response = await _client.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Something went wrong!');
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      return Right(await _client.signOut());
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Something went wrong!');
    }
  }
}
