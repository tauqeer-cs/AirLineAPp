import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_router.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../widgets/app_input_border_text.dart';
import '../../../widgets/app_toast.dart';
import '../bloc/bookings_cubit.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    int _selectedValue = 0;
    var bloc = context.watch<ManageBookingCubit>();

//
    return BlocConsumer<ManageBookingCubit, ManageBookingState>(
      listener: (context, state) {
        if(state.blocState == BlocState.failed){
          Toast.of(context).show(
            success: false,
            message: state.message,
          );

        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
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
                            kVerticalSpacer,
                            const Text("Manage My Booking", style: kGiantHeavy),
                            kVerticalSpacerMini,
                            Text(
                              "Please enter your flight details to view and manage your booking.",
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor),
                            ),
                            kVerticalSpacer,
                            AppInputTextWithBorder(
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
                            kVerticalSpacer,
                            AppInputTextWithBorder(
                              name: "lastName",
                              hintText: "Surname / Last Name",
                              validators: [FormBuilderValidators.required()],
                            ),
                            kVerticalSpacer,
                            kVerticalSpacer,
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      onManageBooking(context);
                                    },
                                    child: const Text('Add on Services'),
                                  ),
                                ),
                                kHorizontalSpacer,
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      bloc.getBookingInformation(
                                          'Ahmead', 'ZV9LE8a');
                                    },
                                    child: const Text('Change flight'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        );
      },
      listenWhen: (_, state) => false, // add this line to disable listening
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
