import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key, required this.showContinueButton}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();
  static const String formEmailLogin = "email-login";
  static const String formPasswordLogin = "password-login";
  final bool showContinueButton;

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
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: _fbKey,
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
              Text(
                "Login",
                style:
                kHugeMedium.copyWith(color: Styles.kPrimaryColor),
              ),
            ],
          ),
          Visibility(
            visible: showContinueButton,
            child: Column(
              children: [
                kVerticalSpacerSmall,
                ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child: Text("Continue As Guest")),
                Row(
                  children: [
                    Expanded(child: AppDividerWidget(color: Styles.kSubTextColor,)),
                    kHorizontalSpacerMini,
                    Text("or"),
                    kHorizontalSpacerMini,
                    Expanded(child: AppDividerWidget(color: Styles.kSubTextColor,)),
                  ],
                ),
                kVerticalSpacerSmall,
              ],
            ),
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
            onPressed: () =>
                context.router.push(const SignupWrapperRoute()),
            child: const Text("Create Acccount"),
          )
        ],
      ),
    );
  }
}
