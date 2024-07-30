import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
          },
          child: const Text('LogOut'),
        ),
      ),
    );
  }
}
