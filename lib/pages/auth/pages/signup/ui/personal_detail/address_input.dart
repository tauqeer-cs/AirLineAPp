import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../../models/country.dart';
import '../../../../../checkout/pages/booking_details/ui/shadow_input.dart';

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

  final TextEditingController _controller = TextEditingController();


   AddressInput(
      {Key? key,
      this.title,
      this.subText,
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
          title: title ?? 'addressQuestion'.tr(),
          subtitle: subText ?? 'addressDesc'.tr(),
          noSpaceSubText: hideSubText,
        ),
        GreyCard(
          margin: 6,
          edgeInsets: const EdgeInsets.all(8),
          child: Column(
            children: [
              AppInputText(
                //isRequired: true,
                maxLength : 128,

                name: formNameAddress,
                validators: [
                  //FormBuilderValidators.required(),
                ],
                hintText: 'address'.tr(),
                initialValue: selectedAddress,
                inputFormatters: [
                  AppFormUtils.denyQuestionMark(),
                ],
              ),
              kVerticalSpacer,
              Row(
                children: [

                  Expanded(
                    child: ShadowInput(
                      name: formNameCountry,

                      textEditingController: _controller,
                      child: AppCountriesDropdown(
                          hideDefualttValue  : true,
                        hintText: 'country'.tr(),
                        isPhoneCode: false,
                        initialCountryCode: selectedCountry,
                        onChanged: (newCountry) {
                          onAddressCountryChange?.call(newCountry);
                          context
                              .read<SignupCubit>()
                              .editCountry(newCountry?.countryCode ?? "");
                        },
                      ),
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                      //isRequired: true,
                      inputFormatters: [
                        AppFormUtils.onlyLetterAndSpace(),
                      ],
                      validators: [
                        //FormBuilderValidators.required(),
                      ],
                      name: formNameState,
                      hintText: 'state'.tr(),
                      initialValue: selectedState,
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: AppInputText(
                      maxLength : 32,
                      validators: [
                       // FormBuilderValidators.required(),
                      ],
                      name: formNameCity,
                      hintText: 'city'.tr(),
                      initialValue: selectedCity,
                      inputFormatters: [
                        AppFormUtils.onlyLetterAndSpace(),
                      ],
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: AppInputText(
                     // isRequired: true,
                      validators: [
                       // FormBuilderValidators.required(),
                      ],
                      name: formNamePostCode,
                      hintText: 'postalCode'.tr(),
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
                  hintText: 'signUp1.email'.tr(),
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
