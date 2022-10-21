import 'package:app/models/country.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class CredentialInput extends StatelessWidget {
  const CredentialInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "Let's create your credentials.",
        ),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: AppCountriesDropdown(
                name: formNamePhoneCode,
                isPhoneCode: true,
                hintText: "Phone",
                initialValue: Country.defaultCountry,
              ),
            ),
            kHorizontalSpacerMini,
            Expanded(
              flex: 5,
              child: AppInputText(
                name: formNamePhone,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                validators: [FormBuilderValidators.required()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
