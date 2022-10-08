import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../theme/theme.dart';

class ListOfPassengerInfo extends StatelessWidget {
  const ListOfPassengerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    return Column(
      children: [
        ...(persons?.persons ?? [])
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PassengerInfo(person: e),
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: const [
              PassengerContact(),
              PassengerEmergencyContact(),
              PassengerCompanyInfo(),
            ],
          ),
        ),
      ],
    );
  }
}

class PassengerContact extends StatelessWidget {
  const PassengerContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppDividerFadeWidget(),
        kVerticalSpacer,
        const Text("Contact", style: kHugeSemiBold),
        kVerticalSpacerSmall,
        const Text(
            "Please ensure you get these details right. We'll email you your travel itinerary and notify you of any important changes to your booking. Your info will be collected in line with our Privacy Policy. "),
        kVerticalSpacer,
        AppInputText(
          name: formNameContactEmail,
          hintText: "Email Address",
          validators: [FormBuilderValidators.required()],
        ),
      ],
    );
  }
}

class PassengerEmergencyContact extends StatelessWidget {
  const PassengerEmergencyContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const AppDividerFadeWidget(),
        kVerticalSpacer,
        const Text("Emergency Contact Person Details", style: kHugeSemiBold),
        kVerticalSpacerSmall,
        const Text(
            " Let us know who we can contact in case of an emergency. Make sure this person isn't a passenger on this flight and is easily reachable. "),
        kVerticalSpacer,
        AppInputText(
          name: formNameEmergencyFirstName,
          hintText: "First Name/Given Name",
          validators: [FormBuilderValidators.required()],
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameEmergencyLastName,
          hintText: "Last Name/Family Name",
          validators: [FormBuilderValidators.required()],
        ),
        kVerticalSpacer,
        FormBuilderDropdown<String>(
          name: formNameEmergencyRelation,
          items: ["Father", "Mother", "Sibling", "Others"]
              .map(
                (e) => DropdownMenuItem<String>(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          decoration: const InputDecoration(hintText: "Relationship"),
          validator: FormBuilderValidators.required(),
        ),
        kVerticalSpacer,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: AppCountriesDropdown(
                name: formNameEmergencyCountry,
                isPhoneCode: true,
                hintText: "Phone",
              ),
            ),
            kHorizontalSpacerMini,
            Expanded(
              flex: 5,
              child: AppInputText(
                name: formNameEmergencyPhone,
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

class PassengerCompanyInfo extends StatelessWidget {
  const PassengerCompanyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const AppDividerFadeWidget(),
        kVerticalSpacer,
        const Text("Company Tax Invoice (Optional)", style: kHugeSemiBold),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyName,
          hintText: "Company",
        ),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyAddress,
          hintText: "Company Address",
        ),
        kVerticalSpacer,
        const AppCountriesDropdown(
          name: formNameEmergencyCountry,
          hintText: "Country",
          isPhoneCode: false,
        ),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyState,
          hintText: "State",
        ),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyCity,
          hintText: "City",
        ),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyPostCode,
          hintText: "Postcode",
        ),
        kVerticalSpacer,
        const AppInputText(
          name: formNameCompanyEmailAddress,
          hintText: "Email Address",
        ),
        kVerticalSpacer,
      ],
    );
  }
}
