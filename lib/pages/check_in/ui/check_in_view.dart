import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/app_flavor.dart';
import '../../../app/app_router.dart';
import '../../../blocs/cms/ssr/cms_ssr_cubit.dart';
import '../../../utils/security_utils.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_input_border_text.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../../widgets/app_toast.dart';
import '../bloc/check_in_cubit.dart';

class CheckInView extends StatelessWidget {
  CheckInView({Key? key}) : super(key: key);

  static final _fbKey = GlobalKey<FormBuilderState>();

  CheckInCubit? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<CheckInCubit>();
    String? checkInLabel = context.watch<CmsSsrCubit>().state.checkInLabel;
    String checkInError = context.watch<CmsSsrCubit>().state.checkInError ?? '';
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: FormBuilder(
        key: _fbKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.9,
          child: AppCard(
            roundedInBottom: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    kVerticalSpacer,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                      child: Text("onlineCheckIn".tr(), style: kGiantHeavy),
                    ),
                    kVerticalSpacerMini,
                    Text(
                      checkInLabel ?? 'webCheckInFAQ'.tr(),
                      style:
                          kMediumRegular.copyWith(color: Styles.kSubTextColor),
                    ),
                    kVerticalSpacer,
                    AppInputTextWithBorder(
                      name: "bookingNumberCheckIn",
                      hintText: 'bookingReference'.tr(),
                      maxLength: 6,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6,
                            errorText: "navBar.bookingReferenceValid".tr()),
                        FormBuilderValidators.maxLength(6,
                            errorText: 'navBar.bookingReferenceValid'.tr()),
                      ],
                    ),
                    kVerticalSpacerSmall,
                    AppInputTextWithBorder(
                      name: "lastNameCheckIn",
                      hintText: "lastNameSurname".tr(),
                      validators: [FormBuilderValidators.required()],
                    ),
                    kVerticalSpacer,
                    bloc?.state.isLoadingInfo == true
                        ? const AppLoading()
                        : ElevatedButton(
                            onPressed: () {
                              if(checkInError.isNotEmpty) {
                                showErrorDialog(context,checkInError);

                                return;
                              }

                              onManageBooking(context);
                            },
                            child: Text('search'.tr()),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void moveToNext(BuildContext context) {
    context.router.push(
      CheckInDetailsRoute(isPast: false),
    );
  }


  onManageBooking(BuildContext context) async {
    if (false) {
      if (_fbKey.currentState!.saveAndValidate()) {
        final value = _fbKey.currentState!.value;
        final code = value["bookingNumberCheckIn"].toString().toUpperCase();
        final lastName = value["lastNameCheckIn"];
        final url =
            "${AppFlavor.thirdPartyUrl}/en/checkin?confirmationNumber=$code&bookingLastName=$lastName";

        context.router
            .push(InAppWebViewRoute(url: url, title: "onlineCheckIn".tr()));

        // launchUrl(Uri.parse("${AppFlavor.thirdPartyUrl}/en/checkin?confirmationNumber=$code&bookingLastName=$lastName"),mode:LaunchMode.inAppWebView );

      }

      return;
    }
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final code = value["bookingNumberCheckIn"];
      final lastName = value["lastNameCheckIn"];

      var flag = await bloc?.getBookingInformation(
        lastName.trim(),
        code.trim().toUpperCase(),
        errorToShow: false
            ? null
            : (String error) {
                showErrorDialog(context, error);
              },
      );

      if (flag == true) {
        moveToNext(context);
      }
    }
  }
}
void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(40, 41, 51, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 15, 0),
        content: Text(errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


