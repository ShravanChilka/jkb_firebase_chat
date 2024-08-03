import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkb_firebase_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:jkb_firebase_chat/modules/search_user/bloc/serch_user_bloc.dart';

class GlobalProviders extends StatelessWidget {
  const GlobalProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<SearchUserBloc>(
          create: (context) => SearchUserBloc(),
        ),
      ],
      child: child,
    );
  }
}
