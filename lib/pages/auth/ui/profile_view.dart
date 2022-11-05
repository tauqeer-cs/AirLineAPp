import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Welcome back ${user?.firstName}"),
        const Spacer(),
        OutlinedButton(
          onPressed: () => context.read<LoginCubit>().logout(),
          child: const Text("Logout"),
        ),
        kVerticalSpacer,
      ],
    );
  }
}
