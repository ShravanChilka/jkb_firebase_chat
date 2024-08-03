import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:jkb_firebase_chat/modules/home/view/home_screen.dart';

import 'auth_screen.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AuthBloc>().add(const AuthEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isAuthenticated) {
          return const HomeScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
