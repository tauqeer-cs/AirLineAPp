import 'package:app/app/app_flavor.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/security_utils.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/app_router.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_input_border_text.dart';
import '../../../widgets/app_loading_screen.dart';
import '../bloc/check_in_cubit.dart';

class CheckInView extends StatelessWidget {


  CheckInView({Key? key}) : super(key: key);

   static final _fbKey = GlobalKey<FormBuilderState>();

  CheckInCubit? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<CheckInCubit>();

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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                      child: Text("Online Check In", style: kGiantHeavy),
                    ),
                    kVerticalSpacerMini,
                    Text(
                      "Web check in available from 48 hours and up to 90 minutes before departure",
                      style:
                          kMediumRegular.copyWith(color: Styles.kSubTextColor),
                    ),
                    kVerticalSpacer,
                    AppInputTextWithBorder(
                      name: "bookingNumberCheckIn",
                      hintText: "Booking Reference Number",
                      maxLength: 6,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6,
                            errorText:
                                "Booking number has to be 6 alphanumeric characters"),
                        FormBuilderValidators.maxLength(6,
                            errorText:
                                "Booking number has to be 6 alphanumeric characters"),
                      ],
                    ),
                    kVerticalSpacerSmall,
                    AppInputTextWithBorder(
                      name: "lastNameCheckIn",
                      hintText: "Surname / Last Name",
                      validators: [FormBuilderValidators.required()],
                    ),
                    kVerticalSpacer,
                    bloc?.state.isLoadingInfo == true
                        ? const AppLoading()
                        : ElevatedButton(
                            onPressed: () {
                              onManageBooking(context);
                            },
                            child: const Text("Search"),
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
      const CheckInDetailsRoute(),
    );
  }

  onManageBooking(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final code = value["bookingNumberCheckIn"];
      final lastName = value["lastNameCheckIn"];

      var flag = await bloc?.getBookingInformation(
          lastName.trim(), code.trim().toUpperCase());

      if (flag == true) {
        moveToNext(context);
      }
    }
  }
}
