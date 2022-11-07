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
  final String? title;
  final String? subText;

  final bool withEmail;

  final bool hideSubText;

  final EdgeInsets? customGreyEdgeInsets;

  final double greyMargin;

  const AddressInput(
      {Key? key,
      this.title,
      this.subText =
          "We will update you with offers that we have based on your address.",
      this.hideSubText = false,
      this.greyMargin = 8.0,
      this.customGreyEdgeInsets, this.withEmail = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: title ?? "What’s your address",
          subtitle: subText,
          noSpaceSubText: hideSubText,
        ),
        GreyCard(
          margin: greyMargin,
          edgeInsets: customGreyEdgeInsets ?? const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const AppInputText(
                  isRequired: false,
                  name: formNameAddress,
                  hintText: 'Address',
                ),
                kVerticalSpacer,
                Row(
                  children: [
                    const Expanded(
                      child: AppCountriesDropdown(
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

                if(withEmail) ... [
                  AppInputText(
                    isRequired: false,
                    textInputType: TextInputType.emailAddress,
                    name: formNameAddressEmail,
                    hintText: 'Email',
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                  ),
                  kVerticalSpacer,


                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
