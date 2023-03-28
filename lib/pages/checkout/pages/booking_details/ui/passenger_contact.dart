import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/error_utils.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/gestures.dart';
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

  final emailController = TextEditingController();

  bool alreadySpaceRemoved = false;

  void removeEmptyFromEmail(String value) async {
    if (emailController.text.isNotEmpty) {
      value = value.trim();
      alreadySpaceRemoved = true;

      await Future.delayed(const Duration(seconds: 1));

      emailController.text = value;
      emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailController.text.length));
      alreadySpaceRemoved = false;
    }
  }

  @override
  void initState() {
    super.initState();
    final contact = true ? null : context.read<LocalUserBloc>().state;
    final profile = context.read<ProfileCubit>().state.profile?.userProfile;
    email = profile?.emailShow ?? contact?.contactEmail.trim();
    firstName = profile?.firstName ?? contact?.contactFullName;
    phoneCode = profile?.phoneCode ?? contact?.contactPhoneCode;
    phoneNumber = profile?.phoneNumber ?? contact?.contactPhoneNumber;
    lastName = profile?.lastName ?? contact?.comment;
    nationalityController.text =
        phoneCode ?? Country.defaultCountry.phoneCode ?? "";
    emailController.text = email ?? '';
    emailController.addListener(() {});
    if ((email ?? '').isNotEmpty) {
      updateEmail(context, email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().state.profile?.userProfile;
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
                    color: Styles.kTextColor, height: 1.5),
              ),
              TextSpan(
                text: "\nYour info will be collected in line with our",
                style: kMediumHeavy.copyWith(
                    color: Styles.kTextColor, height: 1.5),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    try {
                      SecurityUtils.tryLaunch(
                          'https://mya-ibe-prod-bucket.s3.ap-southeast-1.amazonaws.com/odxgmbdo/myairline_privacy-policy.pdf');
                    } catch (e, st) {
                      Toast.of(context).show(message: "Cannot Launch url");
                      ErrorUtils.getErrorMessage(e, st);
                    }
                  },
                text: "\nPrivacy Policy.",
                style: kMediumHeavy.copyWith(
                    color: Styles.kTextColor, height: 1.5),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        kVerticalSpacerSmall,
        Column(
          children: [
            AppInputText(
              name: formNameContactFirstName,
              hintText: "First Name / Given Name",
              validators: [FormBuilderValidators.required()],
              initialValue: profile?.firstName ?? firstName,
              onChanged: (value) {
                final request = context.read<LocalUserBloc>().state;
                final newRequest = request.copyWith(contactFullName: value);
                context.read<LocalUserBloc>().add(UpdateData(newRequest));
              },
            ),
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameContactLastName,
              hintText: "Last Name / Surname",
              validators: [FormBuilderValidators.required()],
              initialValue: profile?.lastName ?? lastName,
              onChanged: (value) {
                final request = context.read<LocalUserBloc>().state;
                final newRequest = request.copyWith(comment: value);
                context.read<LocalUserBloc>().add(UpdateData(newRequest));
              },
            ),
            kVerticalSpacerSmall,
            ShadowInput(
              textEditingController: nationalityController,
              name: formNameContactPhoneCode,
              child: AppCountriesDropdown(
                hintText: "Phone Code",
                isPhoneCode: true,
                dropdownDecoration: Styles.getDefaultFieldDecoration(),
                initialCountryCode: profile?.phoneCode ?? phoneCode,
                onChanged: (value) {
                  nationalityController.text = value?.phoneCode ?? "";
                  final request = context.read<LocalUserBloc>().state;
                  final newRequest =
                      request.copyWith(contactPhoneCode: value?.phoneCode);
                  context.read<LocalUserBloc>().add(UpdateData(newRequest));
                },
              ),
            ),
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameContactPhoneNumber,
              initialValue: profile?.phoneNumber ?? phoneNumber,
              textInputType: TextInputType.number,
              hintText: "Phone Number",
              validators: [FormBuilderValidators.required()],
              onChanged: (value) {
                final request = context.read<LocalUserBloc>().state;
                final newRequest = request.copyWith(contactPhoneNumber: value);
                context.read<LocalUserBloc>().add(UpdateData(newRequest));
              },
            ),
            kVerticalSpacerSmall,
            AppInputText(
              name: formNameContactEmail,
              hintText: "Email Address",
              textInputType: TextInputType.emailAddress,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ],
              //initialValue: profile?.email ?? email,
              textEditingController: emailController,
              onChanged: (value) {
                if (value != null) {
                  if (!alreadySpaceRemoved) {
                    if (value.contains(' ')) {
                      if (alreadySpaceRemoved) {
                        return;
                      } else {
                        removeEmptyFromEmail(value);
                      }
                    }
                  }
                }
                updateEmail(context, value);
              },
            ),
            kVerticalSpacerSmall,
            FormBuilderCheckbox(
              name: formNameContactReceiveEmail,
              title: const Text(
                  "I wish to receive news and promotions from MYAirline by email."),
            ),
          ],
        ),
      ],
    );
  }

  void updateEmail(BuildContext context, String? value) {
    final request = context.read<LocalUserBloc>().state;
    final newRequest = request.copyWith(contactEmail: value?.trim());
    context
        .read<LocalUserBloc>()
        .add(UpdateEmailContact(newRequest.contactEmail));
  }
}
