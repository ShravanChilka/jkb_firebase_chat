import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/phone_auth/bloc/phone_auth_bloc.dart';
import 'package:jkb_firebase_chat/modules/home/view/home_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthStateCodeVerified) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              (state is PhoneAuthStateInital)
                  ? 'Sign in with phone number'
                  : 'Verify code',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(PhoneAuthState state) {
    if (state is PhoneAuthStateInital) {
      return Column(
        children: [
          TextField(
            controller: phoneNumberController,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              context.read<PhoneAuthBloc>().add(
                    PhoneAuthEventSendCode(
                        phoneNumber: phoneNumberController.text),
                  );
            },
            child: const Text('Send code'),
          ),
        ],
      );
    } else if (state is PhoneAuthStateCodeSent) {
      return Column(
        children: [
          TextField(
            controller: codeController,
          ),
          FilledButton(
            onPressed: () {
              context.read<PhoneAuthBloc>().add(
                    PhoneAuthEventVerifyCode(
                      verificationId: state.verificationId,
                      code: codeController.text,
                    ),
                  );
            },
            child: const Text('Verify Code'),
          ),
        ],
      );
    }
    return Container();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    codeController.dispose();
    super.dispose();
  }
}
