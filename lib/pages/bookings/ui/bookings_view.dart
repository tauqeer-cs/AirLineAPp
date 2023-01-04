import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_router.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _fbKey,
              child: GreyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    kVerticalSpacer,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: Text("Manage My Booking", style: kGiantHeavy),
                    ),
                    kVerticalSpacerMini,
                    Text(
                      "Please enter your flight details to view and manage your booking.",
                      style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                    ),
                    kVerticalSpacer,
                    AppInputText(
                      name: "bookingNumber",
                      hintText: "Booking Reference Number",
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
                    AppInputText(
                      name: "lastName",
                      hintText: "Surname / Lastname",
                      validators: [FormBuilderValidators.required()],
                    ),
                    kVerticalSpacer,
                    ElevatedButton(
                        onPressed: () {
                          onManageBooking(context);
                        },
                        child: const Text("Manage Booking"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onManageBooking(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final code = value["bookingNumber"];
      final lastName = value["lastName"];
      final url =
          "${AppFlavor.thirdPartyUrl}/en/manage?confirmationNumber=$code&bookingLastName=$lastName";
      //context.router.push(InAppWebViewRoute(url: url));
      SecurityUtils.tryLaunch(url);

    }
  }
}
