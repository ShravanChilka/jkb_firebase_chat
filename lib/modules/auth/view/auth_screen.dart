import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:jkb_firebase_chat/shared/full_screen_loader.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return FullScreenLoader(
          isLoading: state.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter email address',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      hintText: 'Enter password',
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthEventLogin(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthEventCreateAccount(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    child: const Text('Create Account'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
