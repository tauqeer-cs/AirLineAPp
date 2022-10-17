import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: kPagePadding,
      children: [
        SignInButton(
          Buttons.Apple,
          onPressed: ()=>context.read<LoginCubit>().loginWithApple(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        SignInButton(
          Buttons.Google,
          onPressed: ()=>context.read<LoginCubit>().logInWithGoogle(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }
}
