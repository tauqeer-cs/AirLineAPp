import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final contact =
        true ? null : context.read<LocalUserBloc>().state.emergencyContact;
    final emergency = context
        .read<ProfileCubit>()
        .state
        .profile
        ?.userProfile
        ?.emergencyContact;

    firstName = emergency?.firstName ?? contact?.firstName;
    lastName = emergency?.lastName ?? contact?.lastName;
    phoneNumber = emergency?.phoneNumber ?? contact?.phoneNumber;

    if (emergency?.phoneCode?.isNotEmpty ?? false) {
      nationalityController.text = emergency!.phoneCode!;
    } else if (contact?.phoneCode?.isNotEmpty ?? false) {
      nationalityController.text = contact!.phoneCode!;
    }
    if (emergency?.relationship?.isNotEmpty ?? false) {
      if(availableRelationsMapping[emergency?.relationship?.toLowerCase().tr()] != null) {
        relationController.text = emergency?.relationship?.toLowerCase().tr() ?? emergency!.relationship!;
      }
      else {
        relationController.text = emergency!.relationship!;
      }

    } else if (contact?.relationship?.isNotEmpty ?? false) {

      if(availableRelationsMapping[contact!.relationship?.toLowerCase().tr()] != null) {
        relationController.text = contact.relationship?.toLowerCase().tr() ?? contact.relationship!;
      }
      else {
        relationController.text = contact.relationship!;
      }

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
        Text("emergencyContactLabel".tr(), style: k18Heavy),
        kVerticalSpacerSmall,
        Text(
          "emergencyContactDesc".tr(),
          style: kMediumRegular.copyWith(height: 1.5),
        ),
        kVerticalSpacer,
        Column(
          children: [
            AppInputText(
              name: formNameEmergencyFirstName,
              hintText: "firstNameGivenName".tr(),
              validators: [FormBuilderValidators.required()],
              initialValue: emergency?.firstName ?? firstName,
              onChanged: (value) {
                final request =
                    context.read<LocalUserBloc>().state.emergencyContact ??
                        EmergencyContact();
                final newRequest = request.copyWith(firstName: value);
                context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
              },
            ),
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameEmergencyLastName,
              hintText: "lastNameSurname".tr(),
              validators: [FormBuilderValidators.required()],
              initialValue: emergency?.lastName ?? lastName,
              onChanged: (value) {
                final request =
                    context.read<LocalUserBloc>().state.emergencyContact;
                final newRequest = request?.copyWith(lastName: value);
                context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
              },
            ),
            kVerticalSpacerSmall,
            ShadowInput(
              name: formNameEmergencyRelation,
              textEditingController: relationController,
              validators: [FormBuilderValidators.required()],
              child: AppDropDown<String>(
                dropdownDecoration: Styles.getDefaultFieldDecoration(),
                items: availableRelations,
                defaultValue:
                    availableRelations.contains(relationController.text)
                        ? relationController.text
                        : null,
                sheetTitle: "relationship".tr(),
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
            kVerticalSpacerSmall,
            ShadowInput(
              textEditingController: nationalityController,
              name: formNameEmergencyCountry,
              child: AppCountriesDropdown(
                dropdownDecoration: Styles.getDefaultFieldDecoration(),
                isPhoneCode: true,
                hintText: "phone".tr(),
                initialCountryCode: nationalityController.text,
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
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameEmergencyPhone,
              initialValue: emergency?.phoneNumber ?? phoneNumber,
              textInputType: TextInputType.number,
              hintText: "phoneNumber".tr(),
              validators: [FormBuilderValidators.required()],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                final request =
                    context.read<LocalUserBloc>().state.emergencyContact;
                final newRequest = request?.copyWith(phoneNumber: value);
                context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
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
      ],
    );
  }
}
