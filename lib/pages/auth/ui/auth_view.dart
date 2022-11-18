import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:app/app/app_router.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    Key? key,
    this.showContinueButton = false,
  }) : super(key: key);

  final bool showContinueButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: kPageHorizontalPadding,
        children: [
          kVerticalSpacer,
          Column(
            children: [
              Column(
                children: [
                  const AppLogoWidget(useWhite: true),
                  kVerticalSpacer,
                  Text(
                    "Welcome Back!",
                    style: kGiantRegular.copyWith(color: Colors.white),
                  ),
                ],
              ),
              kVerticalSpacer,
              GlassCard(
                child: LoginForm(
                  fbKey: JosKeys.gKeysAuth,

                  showContinueButton: showContinueButton,
                  formEmailLoginName: "emailAuth",
                  formPasswordLoginName: "passwordAuth",
                ),
              ),
            ],
          ),

          // kVerticalSpacer,
          // Row(
          //   children: [
          //     Expanded(child: AppDividerWidget(color: Colors.grey)),
          //     kHorizontalSpacer,
          //     Text("Or continue with"),
          //     kHorizontalSpacer,
          //     Expanded(child: AppDividerWidget(color: Colors.grey)),
          //   ],
          // ),
          // kVerticalSpacer,
          // SignInButton(
          //   Buttons.Apple,
          //   onPressed: () => context.read<LoginCubit>().loginWithApple(),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // ),
          // SignInButton(
          //   Buttons.Google,
          //   onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // ),
          // kVerticalSpacer,
          // AppDividerWidget(),
          // kVerticalSpacer,
          // Text("Don't have account?"),
          //
        ],
      ),
    );
  }
}
