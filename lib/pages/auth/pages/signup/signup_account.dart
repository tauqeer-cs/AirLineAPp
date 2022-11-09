
import 'package:app/app/app_router.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/credential_input.dart';
import 'package:app/pages/auth/pages/signup/ui/name_input.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignupAccountPage extends StatelessWidget {
  const SignupAccountPage({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  onContinue(BuildContext context) {

    //context.router.replace(CompleteSignupRoute(signupRequest: SignupRequest()));
    //return;
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final signupRequest = SignupRequest(
        firstName: value[formNameFirstName],
        lastName: value[formNameLastName],
        email: value[formNameEmail],
        phoneNumber: value[formNamePhone],
        password: value[formNamePassword],
        confirmPassword: value[formNameConfirmPassword],
      );
      context.read<SignupCubit>().addAccountDetail(signupRequest);
      AutoRouter.of(context).push(const SignupAddressRoute());
    }
  }

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
                    const Expanded(
                        child: Center(child: AppLogoWidget(useWhite: true))),
                    const BackButton(color: Colors.transparent),
                  ],
                ),
                kVerticalSpacer,
                Expanded(
                  child: SignupContainer(
                    step: 1,
                    child: FormBuilder(
                      autoFocusOnValidationFailure: true,

                      key: _fbKey,
                      child: SingleChildScrollView(
                        padding: kPageHorizontalPaddingBig,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kVerticalSpacer,
                            NameInput(),
                            kVerticalSpacer,
                            const CredentialInput(),
                            kVerticalSpacer,
                            const PasswordInput(),
                            kVerticalSpacer,
                            ElevatedButton(
                                onPressed: () => onContinue(context),
                                child: const Text("Continue"))
                          ],
                        ),
                      ),
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
