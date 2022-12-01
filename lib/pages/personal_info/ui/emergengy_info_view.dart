import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
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

class EmergencyInfoView extends StatefulWidget {
  EmergencyInfoView({
    Key? key,
    this.firstName,
    this.lastName,
    this.relationShip,
    this.countryCode,
    this.phoneNo,
    this.onPhoneCodeChanged,
  }) : super(key: key);

  final Function(Country?)? onPhoneCodeChanged;
  final String? firstName;
  final String? lastName;
  final String? relationShip;
  final String? countryCode;
  final String? phoneNo;

  @override
  State<EmergencyInfoView> createState() => _EmergencyInfoViewState();
}

class _EmergencyInfoViewState extends State<EmergencyInfoView> {
  final relationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    relationController.text = widget.relationShip ?? "Father";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormHeader(
          title: 'Emergency Contact Person Details',
          subtitle: 'We’ll call them when there’s an emergency.',
          graySubText: true,
        ),
        GreyCard(
          margin: 5.0,
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
                  initialValue: widget.firstName,
                  validators: [
                    //FormBuilderValidators.required(),
                  ],
                ),
                kVerticalSpacer,
                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameLastNameEmergency,
                  initialValue: widget.lastName,
                  hintText: 'Last Name / Surname',
                  validators: [
                    //FormBuilderValidators.required(),
                  ],
                ),
                kVerticalSpacer,
                ShadowInput(
                  name: formNameRelationshipEmergency,
                  textEditingController: relationController,
                  child: AppDropDown<String>(
                    items: availableRelations,
                    defaultValue:
                        availableRelations.contains(widget.relationShip)
                            ? widget.relationShip
                            : null,
                    sheetTitle: "Relationship",
                    onChanged: (value) {
                      relationController.text = value ?? "";
                    },
                  ),
                ),
                kVerticalSpacer,
                AppCountriesDropdown(
                  isPhoneCode: true,
                  hintText: "Phone",
                  onChanged: widget.onPhoneCodeChanged,
                  initialCountryCode: widget.countryCode,
                ),
                kVerticalSpacer,
                AppInputText(
                  name: formNamePhoneNoRelationship,
                  textInputType: TextInputType.number,
                  hintText: "Phone Number",
                  initialValue: widget.phoneNo,
                  validators: [
                    //FormBuilderValidators.required(),
                  ],
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
