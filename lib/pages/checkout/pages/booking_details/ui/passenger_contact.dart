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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../widgets/pdf_viewer.dart';

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
        Text("contact".tr(), style: k18Heavy),
        kVerticalSpacerSmall,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'contactNotice1'.tr(),
                style: kMediumRegular.copyWith(
                    color: Styles.kTextColor, height: 1.5),
              ),
              TextSpan(
                text: '\n${'contactNotice2'.tr()}',
                style: kMediumHeavy.copyWith(
                    color: Styles.kTextColor, height: 1.5),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewer(
                            title: 'privacyPolicy'.tr(),
                            fileName:
                                'https://mya-ibe-prod-bucket.s3.ap-southeast-1.amazonaws.com/odxgmbdo/myairline_privacy-policy.pdf',
                            pdfIsLink: true,
                          ),
                        ),
                      );
                    } catch (e, st) {
                      Toast.of(context).show(message: 'cantLaunchUrl'.tr());
                      ErrorUtils.getErrorMessage(e, st);
                    }
                  },
                text: "\n${'privacyPolicy'.tr()}.",
                style: kMediumHeavy.copyWith(
                    color: Styles.kPrimaryColor, height: 1.5),
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
              hintText: 'firstName'.tr(),
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
              hintText: 'lastName'.tr(),
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
                hintText: 'phoneCode'.tr(),
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
              hintText: 'infoDetail.phoneNumber'.tr(),
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
              hintText: 'emailAddress'.tr(),
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
              title: Text('iWantReceiveEmail'.tr()),
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
