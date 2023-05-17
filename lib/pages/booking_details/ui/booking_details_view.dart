import 'package:app/models/confirmation_model.dart';
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
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../add_on/ui/passenger_selector.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import 'double_line_text.dart';
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
    final selectedPax =
        context.watch<ManageBookingCubit>().state.selectedPax;
    
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
                kVerticalSpacer,


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








