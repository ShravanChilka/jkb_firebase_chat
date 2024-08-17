import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/email_auth/bloc/auth_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        context.read<AuthBloc>().add(
              const AuthEventLogOut(),
            );
      },
      child: const Text('LogOut'),
    );
  }
}
