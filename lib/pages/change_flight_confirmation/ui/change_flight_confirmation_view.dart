import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../widgets/app_card.dart';
import '../../booking_details/ui/flight_data.dart';
import '../../check_in/bloc/check_in_cubit.dart';
import '../../checkout/pages/booking_confirmation/ui/payment_info.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';

class ChangeFlightConfirmationView extends StatelessWidget {
  const ChangeFlightConfirmationView({Key? key, required this.onShare})
      : super(key: key);

  final VoidCallback onShare;

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

  @override
  Widget build(BuildContext context) {
    ManageBookingCubit bloc = context.watch<ManageBookingCubit>();

    bool showPending = bloc.state.showPending;

    CheckInCubit? blocList = context.watch<CheckInCubit>();

    var state = bloc.state;

    var flightSectionGoing = state.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.first;
    var flightSectionBack = state.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.last;


    blocList.resetStates();
    final locale = context.locale.toString();
    return bloc.state.loadingSummary
        ? const AppLoading()
        : Padding(
            padding: kPageHorizontalPadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  BookingReferenceLabel(
                    refText: bloc.state.pnrEntered,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  if(showPending == true) ... [


                    AppCard(
                      edgeInsets: EdgeInsets.zero,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 4,
                            ),
                            if ((bloc.state.checkedDeparture == true)) ...[
                              FlightDataInfo(
                                headingLabel: 'flightSummary.departure'.tr(),
                                dateToShow:
                                flightSectionGoing?.departureDateToShow(locale) ?? '',
                                departureToDestinationCode: state
                                    .manageBookingResponse
                                    ?.result
                                    ?.departureToDestinationCode ??
                                    '',
                                departureDateWithTime:
                                flightSectionGoing?.departureDateToTwoLine(locale) ??
                                    '',
                                departureAirportName: state.manageBookingResponse
                                    ?.result?.departureAirportName ??
                                    '',
                                journeyTimeInHourMin: state.manageBookingResponse
                                    ?.result?.journeyTimeInHourMin ??
                                    '',
                                arrivalDateWithTime:
                                flightSectionGoing?.arrivalDateToTwoLine(locale) ?? '',
                                arrivalAirportName: state.manageBookingResponse
                                    ?.result?.arrivalAirportName ??
                                    '',
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Divider(),
                              ),
                            ],
                            if ((bloc.state.manageBookingResponse?.isTwoWay ??
                                false) &&
                                (bloc.state.checkReturn == true)) ...[
                              FlightDataInfo(
                                headingLabel: 'flightCharge.return'.tr(),
                                dateToShow:
                                flightSectionBack?.departureDateToShow(locale) ?? '',
                                departureToDestinationCode: state.manageBookingResponse
                                    ?.result
                                    ?.returnToDestinationCode ??
                                    '',
                                departureDateWithTime:
                                flightSectionBack?.departureDateToTwoLine(locale) ?? '',
                                departureAirportName: state.manageBookingResponse
                                    ?.result?.returnDepartureAirportName ??
                                    '',
                                journeyTimeInHourMin: state.manageBookingResponse
                                    ?.result?.returnJourneyTimeInHourMin ??
                                    '',
                                arrivalDateWithTime:
                                flightSectionBack?.arrivalDateToTwoLine(locale) ?? '',
                                arrivalAirportName: state.manageBookingResponse
                                    ?.result?.returnArrivalAirportName ??
                                    '',
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  ] else ... [
                    AppCard(
                      edgeInsets: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: FlightDataInfo(
                                    headingLabel: 'departure'.tr(),
                                    dateToShow: bloc.state.manageBookingResponse
                                        ?.result?.departureDateToShow(locale) ??
                                        '',
                                    departureToDestinationCode: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.departureToDestinationCode ??
                                        '',
                                    departureDateWithTime: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.departureDateWithTime(locale) ??
                                        '',
                                    departureAirportName: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.departureAirportName ??
                                        '',
                                    journeyTimeInHourMin: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.journeyTimeInHourMin ??
                                        '',
                                    arrivalDateWithTime: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.arrivalDateWithTime(locale) ??
                                        '',
                                    arrivalAirportName: bloc
                                        .state
                                        .manageBookingResponse
                                        ?.result
                                        ?.arrivalAirportName ??
                                        '',
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Divider(),
                            ),
                            if (bloc.state.manageBookingResponse?.isTwoWay ??
                                false) ...[
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),

                                  Expanded(
                                    child: FlightDataInfo(
                                      headingLabel: 'return'.tr(),
                                      dateToShow: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnDepartureDateToShow(locale) ??
                                          '',
                                      departureToDestinationCode: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnToDestinationCode ??
                                          '',
                                      departureDateWithTime: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnDepartureDateWithTime(locale) ??
                                          '',
                                      departureAirportName: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnDepartureAirportName ??
                                          '',
                                      journeyTimeInHourMin: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnJourneyTimeInHourMin ??
                                          '',
                                      arrivalDateWithTime: bloc
                                          .state
                                          .manageBookingResponse
                                          ?.result
                                          ?.returnArrivalDateWithTime(locale) ??
                                          '',
                                      arrivalAirportName: bloc
                                          .state
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
                                child:  Text("flightChange.share".tr()),
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
                                onPressed: () async {
                                  bloc.resetData();

                                  await bloc.reloadDataForConfirmation('','');

                                  context.router.replaceAll([
                                    const NavigationRoute(),
                                    ManageBookingDetailsRoute(),
                                  ]);
                                },
                                child: Text('changeFlight'.tr()),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(
                    height: 16,
                  ),
                  PaymentInfo(
                    showPending: showPending,
                    isChange: true,
                    paymentOrders:
                        bloc.state.manageBookingResponse?.result?.paymentOrders,
                  ),
                ],
              ),
            ),
          );
  }

  void onSharedTapped() {
    onShare();
  }
}
