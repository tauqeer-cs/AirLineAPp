import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../blocs/profile/profile_cubit.dart';

class JosKeys {
  static final gKeysAuth = GlobalKey<FormBuilderState>();
  static final gKeysSearch = GlobalKey<FormBuilderState>();
  static final gKeysBooking = GlobalKey<FormBuilderState>();
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.showContinueButton,
    required this.formEmailLoginName,
    required this.formPasswordLoginName,
    required this.fbKey,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> fbKey;
  final String formEmailLoginName;
  final String formPasswordLoginName;
  final bool showContinueButton;

  onLogin(BuildContext context) async {
    if (fbKey.currentState!.saveAndValidate()) {
      final value = fbKey.currentState!.value;
      final email = value[formEmailLoginName];
      final password = value[formPasswordLoginName];
      await context.read<LoginCubit>().logInWithCredentialsFromPopUp(email, password);

      context.read<ProfileCubit>().getProfile();

      await context.read<LoginCubit>().changeStatus();

    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: fbKey,
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
                style: kHugeMedium.copyWith(color: Styles.kPrimaryColor),
              ),
            ],
          ),
          Visibility(
            visible: showContinueButton,
            child: Column(
              children: [
                kVerticalSpacer,
                ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child: const Text("Continue As Guest")),
                kVerticalSpacerSmall,
                Row(
                  children: [
                    Expanded(
                      child: AppDividerWidget(
                        color: Styles.kSubTextColor,
                      ),
                    ),
                    kHorizontalSpacerMini,
                    const Text("or"),
                    kHorizontalSpacerMini,
                    Expanded(
                        child: AppDividerWidget(
                      color: Styles.kSubTextColor,
                    )),
                  ],
                ),
                kVerticalSpacerSmall,
              ],
            ),
          ),
          kVerticalSpacerSmall,
          AppInputText(
            isRequired: false,
            inputDecoration: InputDecoration(
              hintText: "Email Address",
              counterText: "",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
              ),
            ),
            textInputType: TextInputType.emailAddress,
            name: formEmailLoginName,
            hintText: 'Email Address',
            maxLength: 45,
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ],
          ),
          kVerticalSpacer,
          //Text(tr.password, style: kMediumHeavy),
          AppInputPasswordUnderline(
            name: formPasswordLoginName,
            hintText: "Password",


            validators: [FormBuilderValidators.required()],
            isDarkBackground: false,
          ),
          kVerticalSpacerMini,
          TextButton(
              onPressed: () {
                context.router.push(const ForgetPasswordRoute());
              },
              child: Text(
                "Forgotten your password?",
                style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
              )),
          kVerticalSpacerMini,
          ElevatedButton(
            onPressed: () => onLogin(context),
            child: const Text("Login",style: kLargeHeavy,),
          ),
          kVerticalSpacer,
          OutlinedButton(
            onPressed: () => context.router.push(
              const SignupWrapperRoute(),
            ),//kMedium15Heavy
            child: const Text("Create Account",style: kLargeHeavy,),
          )
        ],
      ),
    );
  }
}
