import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../theme/theme.dart';

class ListOfPassengerInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    return Column(
      children: [
        ...(persons?.persons ?? []).map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: PassengerInfo(person: e),
        )).toList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              PassengerContact(),
              PassengerEmergencyContact(),
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
        AppDividerFadeWidget(),
        kVerticalSpacer,
        Text("Contact", style: kHugeSemiBold),
        kVerticalSpacerSmall,
        Text("Please ensure you get these details right. We'll email you your travel itinerary and notify you of any important changes to your booking. Your info will be collected in line with our Privacy Policy. "),
        kVerticalSpacer,
        AppInputText(
          name: "contact_email",
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
        AppDividerFadeWidget(),
        kVerticalSpacer,
        Text("Emergency Contact Person Details", style: kHugeSemiBold),
        kVerticalSpacerSmall,
        Text(" Let us know who we can contact in case of an emergency. Make sure this person isn't a passenger on this flight and is easily reachable. "),
        kVerticalSpacer,
        AppInputText(
          name: "contact_email",
          hintText: "Email Address",
          validators: [FormBuilderValidators.required()],
        ),
      ],
    );
  }
}