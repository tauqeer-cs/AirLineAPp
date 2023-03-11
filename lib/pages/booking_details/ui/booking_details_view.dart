import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
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

    return BlocBuilder<ManageBookingCubit, ManageBookingState>(
      builder: (context, state) {
        return Column(
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
                            headingLabel: 'Departure',
                            dateToShow: state.manageBookingResponse?.result
                                    ?.departureDateToShow ??
                                '',
                            departureToDestinationCode: state
                                    .manageBookingResponse
                                    ?.result
                                    ?.departureToDestinationCode ??
                                '',
                            departureDateWithTime: state.manageBookingResponse
                                    ?.result?.departureDateWithTime ??
                                '',
                            departureAirportName: state.manageBookingResponse
                                    ?.result?.departureAirportName ??
                                '',
                            journeyTimeInHourMin: state.manageBookingResponse
                                    ?.result?.journeyTimeInHourMin ??
                                '',
                            arrivalDateWithTime: state.manageBookingResponse
                                    ?.result?.arrivalDateWithTime ??
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
                    if ((state.manageBookingResponse?.isTwoWay ?? false)) ...[

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: state.checkReturn,
                              onChanged: (bool? value) {
                                bloc?.setCheckReturn(value ?? false);
                              },
                            ),
                          ),
                          Expanded(
                            child: FlightDataInfo(
                              headingLabel: 'Return',
                              dateToShow: state.manageBookingResponse?.result
                                  ?.returnDepartureDateToShow ??
                                  '',
                              departureToDestinationCode: state.manageBookingResponse
                                  ?.result?.returnToDestinationCode ??
                                  '',
                              departureDateWithTime: state
                                  .manageBookingResponse
                                  ?.result
                                  ?.returnDepartureDateWithTime ??
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
                              arrivalDateWithTime: state .manageBookingResponse ?.result ?.returnArrivalDateWithTime ?? '',
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
                                              "Sorry, your flight cannot be changed less than 48 hours before its scheduled departure time");
                                      return;
                                    }
                                    bool? check = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertWarningBeforeProceed();
                                      },
                                    );
                                    //customSelected
                                    bloc?.setFlightDates();

                                    if (check == true) {
                                      context.router.push(
                                        const NewTravelDatesRoute(),
                                      );
                                    }
                                  },
                        child: const Text('Change Flight'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /*
            ChooseFlightSegment(
              title: "Depart",
              subtitle: state.filterState?.beautifyShort ?? "",
              dateTitle: AppDateUtils.formatFullDate(state.filterState?.departDate),
              segments: bookState.selectedDeparture != null
                  ? [bookState.selectedDeparture!]
                  : state.flights?.flightResult?.outboundSegment ?? [],
              isDeparture: true,
            ),*/
          ],
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

class PlaneWithTime extends StatelessWidget {
  final String time;

  const PlaneWithTime({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/icons/icoFlightBlack.png",
          width: 32,
          height: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: Styles.kTextColor,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            time,
            style: kTinyRegular.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class FlightInto extends StatelessWidget {
  final String label;
  final String timeString;
  final String location;

  const FlightInto({
    Key? key,
    required this.label,
    required this.timeString,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: kSmallHeavy.copyWith(color: Styles.kTextColor),
        ),
        Text(
          timeString,
          style: kSmallMedium.copyWith(color: Styles.kTextColor),
        ),
        Text(
          location,
          maxLines: 4,
          style: kSmallMedium.copyWith(color: Styles.kTextColor),

          //icoFlightBlack
        ),
      ],
    );
  }
}

class AlertWarningBeforeProceed extends StatelessWidget {
  const AlertWarningBeforeProceed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Flight Change Requirements",
            textAlign: TextAlign.center,
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Flight ticket changes are subject to the following rules:",
              style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "• You may not change flights if your departure time is less than 48 hours from now.\n"
              "• Your flight destination must be identical to the original.\n"
              "• Your new fare cannot be lower than the original fare.\n"
              "• Meals are subject to availability and the change must be made more than 24 hours before the flight.\n"
              "• If you're travelling for longer than your travel insurance's coverage period, please ensure you are fully covered for the entire trip. Reach out to customer care to extend your coverage.\n"
              "• Your baggage will be transferred over to the new flight.\n"
              "• You may upgrade your baggage upon your flight change.",
              style: kMediumRegular.copyWith(color: Styles.kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Proceed with flight change?",
              style: kMediumRegular.copyWith(color: Styles.kTextColor),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, //isLoading ? null :
                    child: const Text("NO"),
                    /*
                      * isLoading
                          ? const AppLoading(
                        size: 20,
                      )*/
                  ),
                ),
                kHorizontalSpacerSmall,
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Yes"),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
