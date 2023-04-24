import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_router.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../blocs/voucher/voucher_cubit.dart';
import '../../../widgets/app_input_border_text.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../../widgets/app_toast.dart';

class BookingsView extends StatelessWidget {
  BookingsView({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  ManageBookingCubit? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<ManageBookingCubit>();

    return BlocConsumer<ManageBookingCubit, ManageBookingState>(
      listener: (context, state) {
        if (state.blocState == BlocState.failed) {
          if (state.message.isNotEmpty) {
            Toast.of(context).show(
              success: false,
              message: state.message,
            );
          }
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
                            Text('manageMyBookings'.tr(), style: kGiantHeavy),
                            kVerticalSpacerMini,
                            Text(
                              'manageBookingSubText'.tr(),
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor),
                            ),
                            kVerticalSpacer,
                            AppInputTextWithBorder(
                              name: "bookingNumber",
                              hintText: 'bookingReference'.tr(),
                              maxLength: 6,

                              /*inputFormatters: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[A-Za-z0-9\']")),
                              ],
                              */

                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(6,
                                    errorText:
                                        'navBar.bookingReferenceValid'.tr()),
                                FormBuilderValidators.maxLength(6,
                                    errorText:
                                        'navBar.bookingReferenceValid'.tr()),
                              ],
                            ),
                            kVerticalSpacer,
                            AppInputTextWithBorder(
                              name: "lastName",
                              hintText: 'surnameLastName'.tr(),
                              validators: [FormBuilderValidators.required()],
                            ),
                            kVerticalSpacer,
                            kVerticalSpacer,
                            state.isLoadingInfo
                                ? const AppLoading()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            onManageBooking(context);
                                          },
                                          child: Text(
                                            'addonServices'.tr(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      kHorizontalSpacer,
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            onChangeFlightTapped(context);
                                          },
                                          child: Text('changeFlight'.tr()),
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

  onChangeFlightTapped(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;

      String code = value["bookingNumber"];
      String lastName = value["lastName"];

      var flag = await bloc?.getBookingInformation(
          lastName.trim(), code.trim().toUpperCase());
      if (flag == true) {
        moveToNext(context);
      }
    }
  }

  void moveToNext(BuildContext context) {
    context.read<VoucherCubit>().resetState();

    context.router.push(
      ManageBookingDetailsRoute(),
    );
  }
}
