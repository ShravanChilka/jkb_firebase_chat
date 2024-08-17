import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:jkb_firebase_chat/core/utils/firebase_storage_paths.dart';

class ChatStorageService {
  final _client = FirebaseStorage.instance;

  Future<String> uploadFile({
    required String chatId,
    required String filePath,
  }) async {
    final ref = _client.ref(FirebaseStoragePaths.chats).child(chatId).child(
          '${DateTime.now().millisecondsSinceEpoch}.${filePath.split('.').last}',
        );
    final uploadTask = ref.putFile(
      File(filePath),
    );
    return await uploadTask.then((snapshot) async {
      return await snapshot.ref.getDownloadURL();
    });
  }
}
