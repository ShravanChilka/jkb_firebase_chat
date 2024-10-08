import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jkb_firebase_chat/modules/auth/email_auth/model/user_model.dart';

class AuthFirestoreService {
  final _client = FirebaseFirestore.instance;

  Future<Either<String, void>> createUser({
    required UserModel userModel,
  }) async {
    try {
      final ref = _client.collection('users').doc(userModel.id);
      return Right(await ref.set(userModel.toMap()));
    } catch (e) {
      return const Left('Something went wrong!');
    }
  }
}
