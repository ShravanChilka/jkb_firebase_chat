import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jkb_firebase_chat/modules/auth/model/user_model.dart';

class SearchUserFirestoreService {
  final _client = FirebaseFirestore.instance;

  Future<Either<String, List<UserModel>>> searchUser({
    required String query,
  }) async {
    try {
      final response = await _client
          .collection('users')
          .where(
            'email',
            isGreaterThanOrEqualTo: query.trim(),
          )
          .get();
      final docs = response.docs;
      return Right(
        docs.map((doc) => UserModel.fromMap(doc.data())).toList(),
      );
    } catch (e) {
      return const Left('Something went wrong!');
    }
  }
}
