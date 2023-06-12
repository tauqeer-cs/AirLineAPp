import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/booking_details/ui/payment_detials_section.dart';
import 'package:app/pages/booking_details/ui/selected_passenger_info.dart';
import 'package:app/pages/booking_details/ui/warning_before_proceed.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/number_person.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/custom_segment.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../add_on/meals/ui/meals_section.dart';
import '../../add_on/seats/ui/seat_legend_simple.dart';
import '../../add_on/seats/ui/seat_plan.dart';
import '../../add_on/ui/passenger_selector.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import 'add_on_options.dart';
import 'add_ons_card_items.dart';
import 'company_tax_invoice_section.dart';
import 'contants_section.dart';
import 'double_line_text.dart';
import 'emergency_contect_section.dart';
import 'flight_data.dart';

class ManageBookingDetailsView extends StatelessWidget {
  final VoidCallback onSharedTapped;

  ManageBookingDetailsView({Key? key, required this.onSharedTapped})
      : super(key: key);

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Styles.kTextColor;
    }
    return Styles.kPrimaryColor;
  }

  ManageBookingCubit? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<ManageBookingCubit>();
    final locale = context.locale.toString();
    final selectedPax = context.watch<ManageBookingCubit>().state.selectedPax;

    return BlocBuilder<ManageBookingCubit, ManageBookingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BookingReferenceLabel(
                  refText: state.pnrEntered,
                ),
                kVerticalSpacer,
                AppCard(
                  edgeInsets: EdgeInsets.zero,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: state.checkedDeparture,
                                onChanged: (bool? value) {
                                  bloc?.setCheckDeparture(value ?? false);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlightDataInfo(
                                headingLabel: "departure".tr(),
                                dateToShow: state.manageBookingResponse?.result
                                        ?.departureDateToShow(locale) ??
                                    '',
                                departureToDestinationCode: state
                                        .manageBookingResponse
                                        ?.result
                                        ?.departureToDestinationCode ??
                                    '',
                                departureDateWithTime: state
                                        .manageBookingResponse?.result
                                        ?.departureDateWithTime(locale) ??
                                    '',
                                departureAirportName: state
                                        .manageBookingResponse
                                        ?.result
                                        ?.departureAirportName ??
                                    '',
                                journeyTimeInHourMin: state
                                        .manageBookingResponse
                                        ?.result
                                        ?.journeyTimeInHourMin ??
                                    '',
                                arrivalDateWithTime: state
                                        .manageBookingResponse?.result
                                        ?.arrivalDateWithTime(locale) ??
                                    '',
                                arrivalAirportName: state.manageBookingResponse
                                        ?.result?.arrivalAirportName ??
                                    '',
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Divider(),
                        ),
                        if ((state.manageBookingResponse?.isTwoWay ??
                            false)) ...[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: state.checkReturn,
                                  onChanged: (bool? value) {
                                    bloc?.setCheckReturn(value ?? false);
                                  },
                                ),
                              ),
                              Expanded(
                                child: FlightDataInfo(
                                  headingLabel: 'flightCharge.return'.tr(),
                                  dateToShow: state
                                          .manageBookingResponse?.result
                                          ?.returnDepartureDateToShow(locale) ??
                                      '',
                                  departureToDestinationCode: state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnToDestinationCode ??
                                      '',
                                  departureDateWithTime: state
                                          .manageBookingResponse?.result
                                          ?.returnDepartureDateWithTime(
                                              locale) ??
                                      '',
                                  departureAirportName: state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnDepartureAirportName ??
                                      '',
                                  journeyTimeInHourMin: state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnJourneyTimeInHourMin ??
                                      '',
                                  arrivalDateWithTime: state
                                          .manageBookingResponse?.result
                                          ?.returnArrivalDateWithTime(locale) ??
                                      '',
                                  arrivalAirportName: state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnArrivalAirportName ??
                                      '',
                                ),
                              ),
                            ],
                          ),
                        ],
                        kVerticalSpacer,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: OutlinedButton(
                            onPressed: () {
                              onSharedTapped();
                            }, //isLoading ? null :
                            child: Text('flightChange.share'.tr()),
                            /*
                            * isLoading
                                ? const AppLoading(
                              size: 20,
                            )*/
                          ),
                        ),
                        kVerticalSpacerSmall,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            onPressed:
                                (state.checkedDeparture || state.checkReturn) !=
                                        true
                                    ? null
                                    : () async {
                                        //   context.router.replaceAll([const NavigationRoute()]);
                                        final allowedChange =
                                            isAllowedToContinue(state);
                                        if (!allowedChange) {
                                          Toast.of(context).show(
                                              success: false,
                                              message:
                                                  'flightCharge.twoDayChangeError'
                                                      .tr());
                                          return;
                                        }
                                        bool? check = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertWarningBeforeProceed();
                                          },
                                        );
                                        bloc?.setFlightDates();

                                        if (check == true) {
                                          context.router.push(
                                            const NewTravelDatesRoute(),
                                          );
                                        }
                                      },
                            child: Text(
                              'flightResult.changeFlight'.tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kVerticalSpacer,
                PassengerSelectorManageBooking(
                  passengersWithSSR: bloc?.state.manageBookingResponse?.result
                          ?.passengersWithSSRWithoutInfant ??
                      [],
                ),
                kVerticalSpacer,
                SelectedPassengerInfo(selectedPax),
                kVerticalSpacerSmall,
                const AddOnOptions(),
                kVerticalSpacer,
                if (bloc?.state.addOnOptionSelected == AddonType.seat) ...[
                  kVerticalSpacerMini,
                  WarningLabel(message: 'weSorrySeatSelected'.tr(),),
                  kVerticalSpacerSmall,
                  CustomSegmentControl(
                    optionOneTapped: () {},
                    optionTwoTapped: () {},
                    textOne:
                        '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                    textTwo:
                        '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                    customRadius: 12,
                    customBorderWidth: 1,
                    customVerticalPadding: 8,
                    customSelectedStyle:
                        kMediumSemiBold.copyWith(color: Styles.kPrimaryColor),
                    customNoSelectedStyle:
                        kMediumSemiBold.copyWith(color: Styles.kLightBgColor),
                  ),
                  kVerticalSpacer,
                  const SeatLegendSimple(),
                  kVerticalSpacer,
                  SeatPlan(
                    moveToTop: () {
                      //moveToTop?.call();
                    },
                    moveToBottom: () {
                      //  moveToBottom?.call();
                    },
                    isManageBooking: true,
                  ),
                  kVerticalSpacer,
                ] else if (bloc?.state.addOnOptionSelected ==
                    AddonType.meal) ...[

                  WarningLabel(message: 'mealAddOnsAreUnavailable'.tr(),),
                  kVerticalSpacerSmall,
                  CustomSegmentControl(
                    optionOneTapped: () {},
                    optionTwoTapped: () {},
                    textOne:
                    '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                    textTwo:
                    '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                    customRadius: 12,
                    customBorderWidth: 1,
                    customVerticalPadding: 8,
                    customSelectedStyle:
                    kMediumSemiBold.copyWith(color: Styles.kPrimaryColor),
                    customNoSelectedStyle:
                    kMediumSemiBold.copyWith(color: Styles.kLightBgColor),
                  ),
                  kVerticalSpacerSmall,

                  const MealsSection(
                    isDeparture: true,
                    isManageBooking: true,
                  ),
                ],

                const ContactsSection(),
                kVerticalSpacer,
                const EmergencyContactsSection(),
                kVerticalSpacer,
                const ComapnyTaxInvoiceSection(),
                kVerticalSpacer,
                const PaymentDetailsSecond(),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isAllowedToContinue(ManageBookingState manageBookingState) {
    if (manageBookingState.checkedDeparture &&
        !(manageBookingState.manageBookingResponse?.result?.flightSegments
                ?.firstOrNull?.outbound?.firstOrNull?.isChangeAllowed ??
            true)) {
      return false;
    }
    if (manageBookingState.checkReturn &&
        !(manageBookingState.manageBookingResponse?.result?.flightSegments
                ?.firstOrNull?.inbound?.firstOrNull?.isChangeAllowed ??
            true)) {
      return false;
    }
    return true;
  }
}


class WarningLabel extends StatelessWidget {

  final String message;

  const WarningLabel({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Styles.kActiveGrey),
        color: Styles.kActiveGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 16),
        child: Text(
            message ,
          style: kMediumMedium.copyWith(
            color: Styles.kCanvasColor,
          ),
        ),
      ),
    );
  }
}
