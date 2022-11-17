import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PassengerContact extends StatefulWidget {
  const PassengerContact({
    Key? key,
  }) : super(key: key);

  @override
  State<PassengerContact> createState() => _PassengerContactState();
}

class _PassengerContactState extends State<PassengerContact> {
  String? firstName;
  String? lastName;
  String? phoneCode;
  String? phoneNumber;
  String? email;
  final nationalityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final contact = context.read<LocalUserBloc>().state;
    final profile = context.read<ProfileCubit>().state.profile?.userProfile;
    email = profile?.email ?? contact.contactEmail;
    firstName = profile?.firstName ?? contact.contactFullName;
    phoneCode = profile?.phoneCode ?? contact.contactPhoneCode;
    phoneNumber = profile?.phoneNumber ?? contact.contactPhoneNumber;
    lastName = profile?.lastName ?? contact.comment;
    nationalityController.text =
        phoneCode ?? Country.defaultCountry.phoneCode ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().state.profile?.userProfile;
    print("profile is $profile");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppDividerWidget(),
        kVerticalSpacer,
        const Text("Contact", style: k18Heavy),
        kVerticalSpacerSmall,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    "Please ensure you get these details right. We'll email you your travel itinerary and notify you of any important changes to your booking. ",
                style: kMediumRegular.copyWith(
                    color: Styles.kSubTextColor, height: 1.5),
              ),
              TextSpan(
                text: "\nYour info will be collected in line with our",
                style: kMediumHeavy.copyWith(
                    color: Styles.kSubTextColor, height: 1.5),
              ),
              TextSpan(
                text: "\nPrivacy Policy.",
                style: kMediumHeavy.copyWith(
                    color: Styles.kPrimaryColor, height: 1.5),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        kVerticalSpacerSmall,
        GreyCard(
          child: Column(
            children: [
              AppInputText(
                name: formNameContactFirstName,
                hintText: "First Name / Given Name",
                validators: [FormBuilderValidators.required()],
                initialValue: profile?.firstName,
                onChanged: (value) {
                  // final request = context.read<LocalUserBloc>().state;
                  // final newRequest = request.copyWith(contactEmail: value);
                  // context
                  //     .read<LocalUserBloc>()
                  //     .add(UpdateEmailContact(newRequest.contactEmail));
                },
              ),
              AppInputText(
                name: formNameContactLastName,
                hintText: "Last Name / Surname",
                validators: [FormBuilderValidators.required()],
                initialValue: profile?.lastName ?? email,
                onChanged: (value) {
                  // final request = context.read<LocalUserBloc>().state;
                  // final newRequest = request.copyWith(contactEmail: value);
                  // context
                  //     .read<LocalUserBloc>()
                  //     .add(UpdateEmailContact(newRequest.contactEmail));
                },
              ),
              ShadowInput(
                textEditingController: nationalityController,
                name: formNameContactPhoneCode,
                child: AppCountriesDropdown(
                  hintText: "Phone Code",
                  isPhoneCode: true,
                  initialCountryCode: profile?.phoneCode,
                  onChanged: (value) {
                    nationalityController.text = value?.phoneCode ?? "";
                  },
                ),
              ),
              AppInputText(
                name: formNameContactPhoneNumber,
                initialValue: profile?.phoneNumber,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                validators: [FormBuilderValidators.required()],
                onChanged: (value) {
                  // final request =
                  //     context.read<LocalUserBloc>().state.emergencyContact;
                  // final newRequest = request?.copyWith(phoneNumber: value);
                  // context
                  //     .read<LocalUserBloc>()
                  //     .add(UpdateEmergency(newRequest));
                },
              ),
              AppInputText(
                name: formNameContactEmail,
                hintText: "Email Address",
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
                initialValue: profile?.email ?? email,
                onChanged: (value) {
                  final request = context.read<LocalUserBloc>().state;
                  final newRequest = request.copyWith(contactEmail: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateEmailContact(newRequest.contactEmail));
                },
              ),
              FormBuilderCheckbox(
                name: formNameContactReceiveEmail,
                title: const Text(
                    "I wish to receive news and promotions from MYAirline by email."),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
