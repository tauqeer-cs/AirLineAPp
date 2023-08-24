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
import '../../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../../models/confirmation_model.dart';
import '../../../../../theme/theme.dart';

class PassengerEmergencyContact extends StatefulWidget {
  final bool isManageBooking;
  final BookingContact? bookingContact;

  final bool mmbWasEmpty;

  const PassengerEmergencyContact({
    Key? key,
    this.isManageBooking = false,
    this.bookingContact,
    this.mmbWasEmpty = false,
  }) : super(key: key);

  @override
  State<PassengerEmergencyContact> createState() =>
      PassengerEmergencyContactState();
}

class PassengerEmergencyContactState extends State<PassengerEmergencyContact> {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final nationalityController = TextEditingController();
  final relationController = TextEditingController();
  final phoneNoController = TextEditingController();

  bool isMMbEmpty = false;

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
    if(widget.isManageBooking) {

      firstName = widget.bookingContact?.emergencyGivenName ??'';
      firstNameController.text = firstName ?? '';

      lastName = widget.bookingContact?.emergencySurname ?? '';
      lastNameController.text = lastName ?? '';

      phoneNumber = widget.bookingContact?.emergencyPhone ?? '';

      phoneNoController.text = phoneNumber ?? '';

      if (widget.bookingContact?.emergencyPhoneCode?.isNotEmpty ?? false) {
        nationalityController.text = widget.bookingContact?.emergencyPhoneCode ?? '';
        //isMMbEmpty
      } else if (contact?.phoneCode?.isNotEmpty ?? false) {
        nationalityController.text = contact!.phoneCode!;
      }

      if (widget.bookingContact?.emergencyRelationship?.isNotEmpty ?? false) {
        if (availableRelationsMapping[
        widget.bookingContact?.emergencyRelationship?.toLowerCase().tr()] !=
            null) {
          relationController.text = widget.bookingContact?.emergencyRelationship?.toLowerCase().tr() ??
              emergency!.relationship!;
        } else {
          relationController.text = widget.bookingContact?.emergencyRelationship ?? '';
        }
      } else if (contact?.relationship?.isNotEmpty ?? false) {
        if (availableRelationsMapping[
        contact!.relationship?.toLowerCase().tr()] !=
            null) {
          relationController.text =
              contact.relationship?.toLowerCase().tr() ?? contact.relationship!;
        } else {
          relationController.text = contact.relationship!;
        }
      }

    }
    else {
      firstName = emergency?.firstName ?? contact?.firstName;
      firstNameController.text = firstName ?? '';

      lastName = emergency?.lastName ?? contact?.lastName;
      lastNameController.text = lastName ?? '';

      phoneNumber = emergency?.phoneNumber ?? contact?.phoneNumber;

      phoneNoController.text = phoneNumber ?? '';

      if (emergency?.phoneCode?.isNotEmpty ?? false) {
        nationalityController.text = emergency!.phoneCode!;
      } else if (contact?.phoneCode?.isNotEmpty ?? false) {
        nationalityController.text = contact!.phoneCode!;
      }
      if (emergency?.relationship?.isNotEmpty ?? false) {
        if (availableRelationsMapping[
        emergency?.relationship?.toLowerCase().tr()] !=
            null) {
          relationController.text = emergency?.relationship?.toLowerCase().tr() ??
              emergency!.relationship!;
        } else {
          relationController.text = emergency!.relationship!;
        }
      } else if (contact?.relationship?.isNotEmpty ?? false) {
        if (availableRelationsMapping[
        contact!.relationship?.toLowerCase().tr()] !=
            null) {
          relationController.text =
              contact.relationship?.toLowerCase().tr() ?? contact.relationship!;
        } else {
          relationController.text = contact.relationship!;
        }
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

    ManageBookingCubit? manageBloc = context.watch<ManageBookingCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const AppDividerWidget(),
        if(widget.isManageBooking == false) ... [
          kVerticalSpacer,
          Text("emergencyContactLabel".tr(), style: k18Heavy),
        ],
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
              textEditingController: firstNameController,
              onChanged: (value) {
                if(widget.isManageBooking){
                    manageBloc.setEmergencynewValue(value ?? '',isFirstName: true);
                    return;
                }
                else {
                  final request =
                      context.read<LocalUserBloc>().state.emergencyContact ??
                          EmergencyContact();
                  final newRequest = request.copyWith(firstName: value);
                  context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
                }

              },
            ),
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameEmergencyLastName,
              textEditingController: lastNameController,
              hintText: "lastNameSurname".tr(),
              validators: [FormBuilderValidators.required()],
              onChanged: (value) {
                if(widget.isManageBooking){
                  manageBloc.setEmergencynewValue(value ?? '',isLastName: true);
                  return;
                }
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
                  if(widget.isManageBooking){
                    manageBloc.setEmergencynewValue(value ?? '',isRelation: true);
                    return;
                  }
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
                isMMB: widget.isManageBooking && isMMbEmpty,
                dropdownDecoration: Styles.getDefaultFieldDecoration(),
                isPhoneCode: true,
                hintText: "phone".tr(),
                initialCountryCode: nationalityController.text,
                onChanged: (value) {
                  if(widget.isManageBooking){
                    manageBloc.setEmergencynewValue(value?.phoneCode ?? '',isPhoneCode: true);
                    return;
                  }
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
              textEditingController: phoneNoController,
              textInputType: TextInputType.number,
              hintText: "phoneNumber".tr(),
              validators: [FormBuilderValidators.required()],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                if(widget.isManageBooking){
                  manageBloc.setEmergencynewValue(value ?? '',isPhoneNo: true);
                  return;
                }

                final request =
                    context.read<LocalUserBloc>().state.emergencyContact;
                final newRequest = request?.copyWith(phoneNumber: value);
                context.read<LocalUserBloc>().add(UpdateEmergency(newRequest));
              },
            ),

          ],
        ),
      ],
    );
  }

  void reloadData() {
    final contact =
        true ? null : context.read<LocalUserBloc>().state.emergencyContact;
    final emergency = context
        .read<ProfileCubit>()
        .state
        .profile
        ?.userProfile
        ?.emergencyContact;

    firstName = emergency?.firstName ?? contact?.firstName;
    firstNameController.text = firstName ?? '';
    lastName = emergency?.lastName ?? contact?.lastName;
    lastNameController.text = lastName ?? '';

    phoneNumber = emergency?.phoneNumber ?? contact?.phoneNumber;
    phoneNoController.text = phoneNumber ?? '';

    if (emergency?.phoneCode?.isNotEmpty ?? false) {
      nationalityController.text = emergency!.phoneCode!;
    } else if (contact?.phoneCode?.isNotEmpty ?? false) {
      nationalityController.text = contact!.phoneCode!;
    }
    if (emergency?.relationship?.isNotEmpty ?? false) {
      if (availableRelationsMapping[
              emergency?.relationship?.toLowerCase().tr()] !=
          null) {
        relationController.text = emergency?.relationship?.toLowerCase().tr() ??
            emergency!.relationship!;
      } else {
        relationController.text = emergency!.relationship!;
      }
    } else if (contact?.relationship?.isNotEmpty ?? false) {
      if (availableRelationsMapping[
              contact!.relationship?.toLowerCase().tr()] !=
          null) {
        relationController.text =
            contact.relationship?.toLowerCase().tr() ?? contact.relationship!;
      } else {
        relationController.text = contact.relationship!;
      }
    }

    setState(() {});
  }
}
