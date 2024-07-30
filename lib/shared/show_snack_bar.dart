import 'package:flutter/material.dart';
import 'package:jkb_firebase_chat/application.dart';

void showSnackbar(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
