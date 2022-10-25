import 'dart:ui';

import 'package:app/app/app_router.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/credential_input.dart';
import 'package:app/pages/auth/pages/signup/ui/name_input.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CompleteSignupPage extends StatelessWidget {
  final SignupRequest signupRequest;
  const CompleteSignupPage({Key? key, required this.signupRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/design/signup_bg.png",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                kVerticalSpacer,
                Row(
                  children: [
                    BackButton(
                      onPressed: ()=>AutoRouter.of(context).pop(),
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Center(child: AppLogoWidget(useWhite: true))),
                    BackButton(color: Colors.transparent),
                  ],
                ),
                kVerticalSpacer,
                Expanded(
                  child: SignupContainer(
                    step: 3,
                    child: Column(
                      children: [
                        Text('''Please check your email for a link to verify your registration.

Please sign back in after you complete the verification of your email address.''')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
