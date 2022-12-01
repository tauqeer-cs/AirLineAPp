import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../../models/country.dart';

class AddressInput extends StatelessWidget {
  final String? title;
  final String? subText;
  final bool withEmail;
  final bool hideSubText;
  final EdgeInsets? customGreyEdgeInsets;
  final double greyMargin;
  final String? selectedAddress;
  final String? selectedCountry;
  final String? selectedState;
  final String? selectedCity;
  final String? selectedPosCode;
  final Function(Country?)? onAddressCountryChange;

  const AddressInput(
      {Key? key,
      this.title,
      this.subText =
          "We will update you with offers that we have based on your address.",
      this.hideSubText = false,
      this.greyMargin = 8.0,
      this.customGreyEdgeInsets,
      this.withEmail = false,
      this.selectedAddress,
      this.selectedCountry,
      this.selectedState,
      this.selectedCity,
      this.selectedPosCode,
      this.onAddressCountryChange})
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
          edgeInsets: EdgeInsets.all(8),
          child: Column(
            children: [
              AppInputText(
                isRequired: false,
                name: formNameAddress,
                hintText: 'Address',
                initialValue: selectedAddress,
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: AppCountriesDropdown(
                      hintText: "Country",
                      isPhoneCode: false,
                      initialCountryCode: selectedCountry,
                      onChanged: (newCountry) {
                        onAddressCountryChange?.call(newCountry);
                        context
                            .read<SignupCubit>()
                            .editCountry(newCountry?.countryCode2 ?? "");
                      },
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                      isRequired: false,
                      name: formNameState,
                      hintText: 'State',
                      initialValue: selectedState,
                      inputFormatters: [
                        AppFormUtils.onlyLetter(),
                      ],
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
                      initialValue: selectedCity,
                      inputFormatters: [
                        AppFormUtils.onlyLetter(),
                      ],
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                      isRequired: false,
                      name: formNamePostCode,
                      hintText: 'Postal Code',
                      initialValue: selectedPosCode,
                      inputFormatters: [
                        AppFormUtils.onlyNumber(),
                      ],
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              if (withEmail) ...[
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
      ],
    );
  }
}
