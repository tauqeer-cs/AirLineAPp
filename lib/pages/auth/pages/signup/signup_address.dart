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
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_divider_widget.dart';
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
        country: (value[formNameCountry] as Country).countryCode2,
        gender: value[formNameGender],
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
              GenderInput(),
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
              ElevatedButton(onPressed: ()=>onSignup(context), child: Text("Continue"))
            ],
          ),
        ),
      ),
    );
  }
}
