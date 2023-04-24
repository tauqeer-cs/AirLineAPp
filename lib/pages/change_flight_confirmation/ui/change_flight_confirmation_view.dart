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
                  AppCard(
                    edgeInsets: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              true
                                  ? const SizedBox(
                                      width: 16,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: bloc.state.checkedDeparture,
                                        onChanged: (bool? value) {
                                          bloc.setCheckDeparture(
                                              value ?? false);
                                        },
                                      ),
                                    ),
                              Expanded(
                                child: FlightDataInfo(
                                  headingLabel: 'Departure',
                                  dateToShow: bloc.state.manageBookingResponse
                                          ?.result?.departureDateToShow ??
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
                                          ?.departureDateWithTime ??
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
                                          ?.arrivalDateWithTime ??
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
                                true
                                    ? const SizedBox(
                                        width: 16,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: bloc.state.checkReturn,
                                          onChanged: (bool? value) {
                                            bloc.setCheckReturn(value ?? false);
                                          },
                                        ),
                                      ),
                                Expanded(
                                  child: FlightDataInfo(
                                    headingLabel: 'Return',
                                    dateToShow: bloc
                                            .state
                                            .manageBookingResponse
                                            ?.result
                                            ?.returnDepartureDateToShow ??
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
                                            ?.returnDepartureDateWithTime ??
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
                                            ?.returnArrivalDateWithTime ??
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
                              child: const Text("Share"),
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

                                await bloc.reloadDataForConfirmation();

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
                  const SizedBox(
                    height: 16,
                  ),
                  PaymentInfo(
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
