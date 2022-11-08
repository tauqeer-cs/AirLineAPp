import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../models/country.dart';
import '../../../theme/spacer.dart';
import '../../../widgets/app_countries_dropdown.dart';
import '../../../widgets/containers/grey_card.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../auth/pages/signup/signup_wrapper.dart';
import '../../auth/pages/signup/ui/form_header.dart';


class EmergencyInfoView extends StatelessWidget {
  const EmergencyInfoView({Key? key, this.firstName, this.lastName, this.relationShip, this.countryCode, this.phoneNo}) : super(key: key);

  final String? firstName;
  final String? lastName;
  final String? relationShip;
  final String? countryCode;
  final String? phoneNo;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:   [
        const FormHeader(
          title: 'Emergency Contact Person Details',
          subtitle: 'We’ll call them when there’s an emergency.',
          graySubText: true,
        ),
        GreyCard(
          margin: 0.0,
          edgeInsets: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameFirstNameEmergency,
                  hintText: 'First Name / Given Name',
                  initialValue: firstName,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),

                kVerticalSpacer,

                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameLastNameEmergency ,
                  initialValue: lastName,
                  hintText: 'Last Name / Surname',
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),

                kVerticalSpacer,


                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameRelationshipEmergency  ,
                  initialValue: relationShip,
                  hintText: 'Relationship',
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),

                kVerticalSpacer,


                const AppCountriesDropdown(
                  isPhoneCode: true,
                  hintText: "Phone",
                  initialValue: Country.defaultCountry,

                ),
                kVerticalSpacer,
                AppInputText(
                  name: formNamePhoneRelationship,
                  textInputType: TextInputType.number,
                  hintText: "Phone Number",
                  initialValue: phoneNo,
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
