import 'package:flutter/material.dart';

import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../models/country.dart';
import '../../../theme/spacer.dart';
import '../../../widgets/app_countries_dropdown.dart';
import '../../auth/pages/signup/signup_wrapper.dart';


class AdditionInfoView extends StatelessWidget {
  const AdditionInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children:  [
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
                const AppCountriesDropdown(
                  hintText: "Nationality",
                  isPhoneCode: false,
                ),
                kVerticalSpacer,

                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameMyKad,
                  hintText: 'MyKad Number',
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
                kVerticalSpacer,


                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.emailAddress,
                  name: formNameEmail,
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
                  format: DateFormat("dd MMM yyyy"),
                  initialDate: DateTime(2000),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  decoration: InputDecoration(
                      hintText: "Date of Birth",
                      suffixIcon: Icon(Icons.calendar_month_sharp),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12)
                  ),
                  inputType: InputType.date,
                ),
                kVerticalSpacer,
                const AppCountriesDropdown(
                  isPhoneCode: true,
                  hintText: "Phone",
                  initialValue: Country.defaultCountry,
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
        ),
      ],
    );
  }
}
