import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
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
  final nationalityController = TextEditingController();
  final relationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final contact = context.read<LocalUserBloc>().state.emergencyContact;
    firstName = contact?.firstName;
    lastName = contact?.lastName;
    phoneNumber = contact?.phoneNumber;
    nationalityController.text = Country.defaultCountry.phoneCode ?? "";
    relationController.text = "Father";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const AppDividerWidget(),
        kVerticalSpacer,
        const Text("Emergency Contact Person Details", style: k18Heavy),
        kVerticalSpacerSmall,
        Text(
          "Let us know who we can contact in case of an emergency. Make sure this person isn't a passenger on this flight and is easily reachable. ",
          style:
              kMediumRegular.copyWith(color: Styles.kSubTextColor, height: 1.5),
        ),
        kVerticalSpacer,
        GreyCard(
          child: Column(
            children: [
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
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateEmergency(newRequest));
                },
              ),
              kVerticalSpacerMini,
              AppInputText(
                name: formNameEmergencyLastName,
                hintText: "Last Name/Family Name",
                validators: [FormBuilderValidators.required()],
                initialValue: lastName,
                onChanged: (value) {
                  final request =
                      context.read<LocalUserBloc>().state.emergencyContact;
                  final newRequest = request?.copyWith(lastName: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateEmergency(newRequest));
                },
              ),
              kVerticalSpacerMini,
              ShadowInput(
                name: formNameEmergencyRelation,
                textEditingController: relationController,
                child: AppDropDown<String>(
                  items: ["Father", "Mother", "Sibling", "Friends", "Other"],
                  defaultValue: "Father",
                  sheetTitle: "Relationship",
                  onChanged: (value) {
                    relationController.text = value ?? "";
                  },
                ),
              ),
              kVerticalSpacerMini,
              ShadowInput(
                textEditingController: nationalityController,
                name: formNameEmergencyCountry,
                child: AppCountriesDropdown(
                  isPhoneCode: true,
                  hintText: "Phone",
                  initialValue: Country.defaultCountry,
                  onChanged: (value) {
                    nationalityController.text = value?.phoneCode ?? "";
                  },
                ),
              ),
              AppInputText(
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
              AppInputText(
                name: formNameEmergencyEmail,
                hintText: "Email",
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
                //initialValue: lastName,
                onChanged: (value) {
                  // final request =
                  //     context.read<LocalUserBloc>().state.emergencyContact;
                  // final newRequest = request?.copyWith(lastName: value);
                  // context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
