import 'package:app/app/app_router.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/credential_input.dart';
import 'package:app/pages/auth/pages/signup/ui/name_input.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignupAccountPage extends StatelessWidget {
  const SignupAccountPage({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  onContinue(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final signupRequest = SignupRequest(
        title: value[formNameTitle],
        firstName: value[formNameFirstName],
        lastName: value[formNameLastName],
        email: value[formNameEmail],
        phoneCode: (value[formNamePhoneCode] as Country).phoneCode,
        phoneNumber: value[formNamePhone],
        password: value[formNamePassword],
        confirmPassword: value[formNameConfirmPassword],
      );
      context.read<SignupCubit>().addAccountDetail(signupRequest);
      AutoRouter.of(context).push(SignupAddressRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: ()=>AutoRouter.of(context).pop(),
        ),
        title: Text("Create Account"),
      ),
      body: FormBuilder(
        key:_fbKey,
        child: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameInput(),
              kVerticalSpacer,
              AppDividerWidget(color: Styles.kTextColor),
              kVerticalSpacer,
              CredentialInput(),
              kVerticalSpacer,
              AppDividerWidget(color: Styles.kTextColor),
              kVerticalSpacer,
              PasswordInput(),
              kVerticalSpacer,
              AppDividerWidget(color: Styles.kTextColor),
              kVerticalSpacer,
              ElevatedButton(onPressed: ()=>onContinue(context), child: Text("Continue"))
            ],
          ),
        ),
      ),
    );
  }
}
