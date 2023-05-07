import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/validate_email/validate_email_cubit.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/credential_input.dart';
import 'package:app/pages/auth/pages/signup/ui/name_input.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignupAccountPage extends StatefulWidget {
  const SignupAccountPage({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  @override
  State<SignupAccountPage> createState() => _SignupAccountPageState();
}

class _SignupAccountPageState extends State<SignupAccountPage> {
  late FocusNode focusNodeEmail;

  final step = 1;

  onContinue(BuildContext context) {
    //context.router.replace(CompleteSignupRoute(signupRequest: SignupRequest()));
    //return;
    if (SignupAccountPage._fbKey.currentState!.saveAndValidate()) {
      final value = SignupAccountPage._fbKey.currentState!.value;
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
  void initState() {
    super.initState();
    UserInsider.of(context)
        .registerStandardEvent(InsiderConstants.registrationStarted);
    focusNodeEmail = FocusNode();
    focusNodeEmail.addListener(() {
      if (!focusNodeEmail.hasFocus) {
        SignupAccountPage._fbKey.currentState!.save();
        final value = SignupAccountPage._fbKey.currentState!.value;
        final email = value[formNameEmail];
        context.read<ValidateEmailCubit>().validateEmail(email);
      }
    });
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    super.dispose();
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
          body: Column(
            children: [
              kVerticalSpacerHuge,
              Row(
                children: [
                  BackButton(
                    onPressed: () => AutoRouter.of(context).pop(),
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
                  step: step,
                  child: FormBuilder(
                    autoFocusOnValidationFailure: true,
                    key: SignupAccountPage._fbKey,
                    child: SingleChildScrollView(
                      padding: kPageHorizontalPaddingBig,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SignupHeader(step: step),
                          Visibility(
                            visible: step != 3,
                            child: Text(
                              step == 1
                                  ? 'signUp1.signUpDesc'.tr()
                                  : 'worryNot'.tr(),
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor, fontSize: 16),
                            ),
                          ),
                          kVerticalSpacer,
                          const NameInput(isSignUp: true),
                          kVerticalSpacer,
                          CredentialInput(focusNode: focusNodeEmail),
                          kVerticalSpacer,
                          const PasswordInput(),
                          kVerticalSpacer,
                          BlocBuilder<ValidateEmailCubit, GenericState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state.blocState == BlocState.finished
                                    ? () => onContinue(context)
                                    : null,
                                child: Text('signUp3.continue'.tr()),
                              );
                            },
                          ),
                          kVerticalSpacer,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    Key? key,
    required this.step,
  }) : super(key: key);

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            step == 1 ? "signUp".tr() : "personalInformation".tr(),
            style: kGiantSemiBold.copyWith(
                color: Styles.kPrimaryColor,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
        ),
        kHorizontalSpacer,
        CircleAvatar(
          radius: 15,
          backgroundColor: step == 1 ? Styles.kActiveColor : Colors.white,
          child: Text(
            "1",
            style: kLargeHeavy.copyWith(
              color: step == 1 ? Colors.white : Styles.kDisabledButton,
            ),
          ),
        ),
        kHorizontalSpacerSmall,
        kHorizontalSpacerMini,
        CircleAvatar(
          radius: 15,
          backgroundColor: step == 2 ? Styles.kActiveColor : Colors.white,
          child: Text(
            "2",
            style: kLargeHeavy.copyWith(
              color: step == 2 ? Colors.white : Styles.kDisabledButton,
            ),
          ),
        ),
      ],
    );
  }
}
