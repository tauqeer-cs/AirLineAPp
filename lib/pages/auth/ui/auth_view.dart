import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/containers/version_widget.dart';
import 'package:flutter/material.dart';

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
              kVerticalSpacerHuge,
              kVerticalSpacerHuge,
              const VersionWidget(textColor: Colors.white,),
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
