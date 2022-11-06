import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);
  static const String formEmailLogin = "email-login";
  static const String formPasswordLogin = "password-login";
  static final _fbKey = GlobalKey<FormBuilderState>();

  onLogin(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final email = value[formEmailLogin];
      final password = value[formPasswordLogin];
      context.read<LoginCubit>().logInWithCredentials(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: kPagePadding,
      children: [
        FormBuilder(
          autoFocusOnValidationFailure: true,
          key: _fbKey,
          child: Column(
            children: [
              kVerticalSpacer,
              Column(
                children: [
                  const AppLogoWidget(useWhite: true),
                  kVerticalSpacer,
                  Text("Welcome Back!", style: kGiantRegular.copyWith(color: Colors.white),),
                ],
              ),
              kVerticalSpacer,
              GlassCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          MyFlutterApp.icon0vector49301__1_,
                          color: Styles.kPrimaryColor,
                          size: 20,
                        ),
                        kHorizontalSpacerMini,
                        Text("Login", style: kHugeMedium.copyWith(color: Styles.kPrimaryColor),),
                      ],
                    ),
                    AppInputText(
                      isRequired: false,
                      textInputType: TextInputType.emailAddress,
                      name: formEmailLogin,
                      hintText: 'Email Address',
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                    ),
                    kVerticalSpacer,
                    //Text(tr.password, style: kMediumHeavy),
                    AppInputPassword(
                      name: formPasswordLogin,
                      hintText: "Password",
                      validators: [FormBuilderValidators.required()],
                      isDarkBackground: false,
                    ),
                    kVerticalSpacer,
                    ElevatedButton(
                      onPressed: () => onLogin(context),
                      child: const Text("Login"),
                    ),
                    kVerticalSpacerSmall,
                    OutlinedButton(
                      onPressed: () => context.router.push(const SignupWrapperRoute()),
                      child: const Text("Create Acccount"),
                    )
                  ],
                ),
              ),
            ],
          ),
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
    );
  }
}
