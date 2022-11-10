import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  final Widget authChild;
  final Widget child;
  const AuthWrapper({Key? key, required this.authChild, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state.user!=null && state.user != User.empty && (state.user?.isAccountVerified ?? false)){
          return authChild;
        }
        return child;
      },
    );
  }
}
