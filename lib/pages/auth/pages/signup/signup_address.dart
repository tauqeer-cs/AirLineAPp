import 'package:app/app/app_router.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/credential_input.dart';
import 'package:app/pages/auth/pages/signup/ui/name_input.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/address_input.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/dob_input.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/gender_input.dart';
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

class SignupAddressPage extends StatelessWidget {
  const SignupAddressPage({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  onSignup(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final signupRequest = SignupRequest(
        city: value[formNameCity],
        address: value[formNameAddress],
        dob: value[formNameDob],
        postCode: value[formNamePostCode],
        state: value[formNameState],
      );
      context.read<SignupCubit>().signup(signupRequest);
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
          body: Column(
            children: [
              kVerticalSpacer,
              Row(
                children: [
                  BackButton(
                    onPressed: ()=>AutoRouter.of(context).pop(),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Center(child: AppLogoWidget(useWhite: true)),
                  ),
                  BackButton(color: Colors.transparent),
                ],
              ),
              kVerticalSpacer,
              Expanded(
                child: SignupContainer(
                  step: 2,
                  child: FormBuilder(
                    autoFocusOnValidationFailure: true,

                    key: _fbKey,
                    child: SingleChildScrollView(
                      padding: kPageHorizontalPaddingBig,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kVerticalSpacer,
                          GenderInput(
                            onChanged: (value)=>context.read<SignupCubit>().editGender(value ?? "Male"),
                          ),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                          DobInput(),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                          AddressInput(),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                          ElevatedButton(
                            onPressed: () => onSignup(context),
                            child: Text("Continue"),
                          )
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
