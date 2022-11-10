import 'package:flutter/material.dart';

import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../localizations/localizations_util.dart';
import '../../../models/country.dart';
import '../../../theme/spacer.dart';
import '../../../widgets/app_countries_dropdown.dart';
import '../../auth/pages/signup/signup_wrapper.dart';

class AdditionInfoView extends StatelessWidget {
  final String? countrySelected;
  final String? myKadSelected;
  final String? emailSelected;
  final DateTime? dobSelected;
  final String? phoneCountryCodeSelected;
  final String? phoneSelected;

  final Function(Country?)? onCountryChange;

  final Function(Country?)? phoneCountryCode;

  const AdditionInfoView(
      {Key? key,
      this.countrySelected,
      this.myKadSelected,
      this.emailSelected,
      this.dobSelected,
      this.phoneCountryCodeSelected,
      this.phoneSelected,
      this.onCountryChange,
      this.phoneCountryCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormHeader(
          title: 'Additional Info',
        ),
        GreyCard(
          margin: 0.0,
          edgeInsets: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppCountriesDropdown(
                  hintText: 'Nationality',
                  isPhoneCode: false,
                  onChanged: onCountryChange,
                  initialCountryCode: countrySelected,
                ),
                kVerticalSpacer,
                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameMyKad,
                  hintText: 'MyKad Number',
                  initialValue: myKadSelected,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
                kVerticalSpacer,
                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.emailAddress,
                  name: formNameEmail,
                  initialValue: emailSelected,
                  hintText: 'Email',
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ],
                ),
                kVerticalSpacer,
                FormBuilderDateTimePicker(
                  name: formNameDob,
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                  initialValue: dobSelected,
                  format: DateFormat("dd MMM yyyy"),
                  onChanged: (newData) {},
                  initialDate: DateTime(2000),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  decoration: const InputDecoration(
                      hintText: "Date of Birth",
                      suffixIcon: Icon(Icons.calendar_month_sharp),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12)),
                  inputType: InputType.date,
                ),
                kVerticalSpacer,
                AppCountriesDropdown(
                  isPhoneCode: true,
                  hintText: "Phone Code",
                  initialValue: Country.defaultCountry,
                  initialCountryCode: phoneCountryCodeSelected,
                  onChanged: (Country? newPhCountry) {
                    phoneCountryCode?.call(newPhCountry);
                  },
                ),
                kVerticalSpacer,
                AppInputText(
                  name: formNamePhone,
                  textInputType: TextInputType.number,
                  hintText: "Phone Number",
                  initialValue: phoneSelected,
                  validators: [FormBuilderValidators.required()],
                ),
                kVerticalSpacer,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
