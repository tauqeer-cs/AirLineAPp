import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class AddressInput extends StatelessWidget {
  const AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "What’s your address",
          subtitle: "We will update you with offers that we have based on your address. ",
        ),
        GreyCard(
          child: Column(
            children: [
              AppInputText(
                isRequired: false,
                name: formNameAddress,
                hintText: 'Address',
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: const AppCountriesDropdown(
                      name: formNameCountry,
                      hintText: "Country",
                      isPhoneCode: false,
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                      isRequired: false,
                      name: formNameState,
                      hintText: 'State',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: AppInputText(
                      isRequired: false,
                      name: formNameCity,
                      hintText: 'City',
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                      isRequired: false,
                      name: formNamePostCode,
                      hintText: 'Postal Code',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
            ],
          ),
        ),
        

        

      ],
    );
  }
}
