import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/phone_auth/bloc/phone_auth_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/phone_auth/view/phone_auth_screen.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBloc(),
      child: const PhoneAuthScreen(),
    );
  }
}
