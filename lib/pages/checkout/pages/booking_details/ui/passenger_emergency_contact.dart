

import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../theme/theme.dart';

class PassengerEmergencyContact extends StatefulWidget {
  const PassengerEmergencyContact({
    Key? key,
  }) : super(key: key);

  @override
  State<PassengerEmergencyContact> createState() =>
      _PassengerEmergencyContactState();
}

class _PassengerEmergencyContactState extends State<PassengerEmergencyContact> {
  String? firstName;
  String? lastName;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    final contact = context.read<LocalUserBloc>().state.emergencyContact;
    firstName = contact?.firstName;
    lastName = contact?.lastName;
    phoneNumber = contact?.phoneNumber;
  }

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
          initialValue: firstName,
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.emergencyContact ??
                    EmergencyContact();
            final newRequest = request.copyWith(firstName: value);
            context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
          },
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameEmergencyLastName,
          hintText: "Last Name/Family Name",
          validators: [FormBuilderValidators.required()],
          initialValue: lastName,
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.emergencyContact;
            final newRequest = request?.copyWith(lastName: value);
            context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
          },
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
                isPhoneCode: true,
                hintText: "Phone",
                initialValue: Country.defaultCountry,
              ),
            ),
            kHorizontalSpacerMini,
            Expanded(
              flex: 5,
              child: AppInputText(
                name: formNameEmergencyPhone,
                initialValue: phoneNumber,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                validators: [FormBuilderValidators.required()],
                onChanged: (value) {
                  final request =
                      context.read<LocalUserBloc>().state.emergencyContact;
                  final newRequest = request?.copyWith(phoneNumber: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateEmergency(newRequest));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}