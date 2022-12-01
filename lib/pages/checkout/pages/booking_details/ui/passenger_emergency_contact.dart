import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String? email;

  final nationalityController = TextEditingController();
  final relationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final contact = context.read<LocalUserBloc>().state.emergencyContact;
    final emergency = context
        .read<ProfileCubit>()
        .state
        .profile
        ?.userProfile
        ?.emergencyContact;

    firstName = emergency?.firstName ?? contact?.firstName;
    lastName = emergency?.lastName ?? contact?.lastName;
    phoneNumber = emergency?.phoneNumber ?? contact?.phoneNumber;
    nationalityController.text = emergency?.phoneCode ??
        contact?.phoneCode ??
        Country.defaultCountry.phoneCode ??
        "";
    if(emergency?.relationship !=null){
      relationController.text = emergency!.relationship!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final emergency = context
        .watch<ProfileCubit>()
        .state
        .profile
        ?.userProfile
        ?.emergencyContact;

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
                initialValue: emergency?.firstName ?? firstName,
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
                hintText: "Last Name/Surname",
                validators: [FormBuilderValidators.required()],
                initialValue: emergency?.lastName ?? lastName,
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
                  items: const [
                    "Father",
                    "Mother",
                    "Sibling",
                    "Friends",
                    "Other"
                  ],
                  defaultValue:
                      availableRelations.contains(relationController.text)
                          ? relationController.text
                          : null,
                  sheetTitle: "Relationship",
                  onChanged: (value) {
                    relationController.text = value ?? "";
                    final request =
                        context.read<LocalUserBloc>().state.emergencyContact;
                    final newRequest = request?.copyWith(relationship: value);
                    context
                        .read<LocalUserBloc>()
                        .add(UpdateEmergency(newRequest));
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
                  initialCountryCode: emergency?.phoneCode ?? phoneNumber,
                  onChanged: (value) {
                    nationalityController.text = value?.phoneCode ?? "";
                    final request =
                        context.read<LocalUserBloc>().state.emergencyContact;
                    final newRequest =
                        request?.copyWith(phoneNumber: value?.phoneCode);
                    context
                        .read<LocalUserBloc>()
                        .add(UpdateEmergency(newRequest));
                  },
                ),
              ),
              AppInputText(
                name: formNameEmergencyPhone,
                initialValue: emergency?.phoneNumber ?? phoneNumber,
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
              /*AppInputText(
                name: formNameEmergencyEmail,
                hintText: "Email",

                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
                onChanged: (value) {
                  final request =
                      context.read<LocalUserBloc>().state.emergencyContact;
                  final newRequest = request?.copyWith(email: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateEmergency(newRequest));
                },
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
