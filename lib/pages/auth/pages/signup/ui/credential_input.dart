import 'package:app/models/country.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class CredentialInput extends StatelessWidget {
  const CredentialInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormHeader(
          title: "Let's create your credentials.",
        ),
        GreyCard(
          edgeInsets: const EdgeInsets.all(8),
          child: Column(
            children: [
              AppInputText(
                isRequired: false,
                textInputType: TextInputType.emailAddress,
                name: formNameEmail,
                hintText: 'Email Address',
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
              ),
              kVerticalSpacer,
              AppCountriesDropdown(
                isPhoneCode: true,
                hintText: "Phone",
                initialValue: Country.defaultCountry,
                onChanged: (country){
                  context
                      .read<SignupCubit>()
                      .editPhoneCode(country?.phoneCode ?? "");
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNamePhone,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                validators: [FormBuilderValidators.required()],
              ),
              kVerticalSpacer,
            ],
          ),
        ),
        
      ],
    );
  }
}
