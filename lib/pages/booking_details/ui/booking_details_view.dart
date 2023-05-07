import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final locale = context.locale.toString();

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
                                    ?.departureDateToShow(locale) ??
                                '',
                            departureToDestinationCode: state
                                    .manageBookingResponse
                                    ?.result
                                    ?.departureToDestinationCode ??
                                '',
                            departureDateWithTime: state.manageBookingResponse
                                    ?.result?.departureDateWithTime(locale) ??
                                '',
                            departureAirportName: state.manageBookingResponse
                                    ?.result?.departureAirportName ??
                                '',
                            journeyTimeInHourMin: state.manageBookingResponse
                                    ?.result?.journeyTimeInHourMin ??
                                '',
                            arrivalDateWithTime: state.manageBookingResponse
                                    ?.result?.arrivalDateWithTime(locale) ??
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
                              headingLabel: 'flightCharge.return'.tr(),
                              dateToShow: state.manageBookingResponse?.result
                                  ?.returnDepartureDateToShow(locale) ??
                                  '',
                              departureToDestinationCode: state.manageBookingResponse
                                  ?.result?.returnToDestinationCode ??
                                  '',
                              departureDateWithTime: state
                                  .manageBookingResponse
                                  ?.result
                                  ?.returnDepartureDateWithTime(locale) ??
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
                              arrivalDateWithTime: state .manageBookingResponse ?.result ?.returnArrivalDateWithTime(locale) ?? '',
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
                        child:  Text('flightChange.share'.tr()),
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
                                              'flightCharge.twoDayChangeError'.tr());
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
                        child:  Text('flightResult.changeFlight'.tr()),
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
  final bool showDisabled;

  const PlaneWithTime({
    Key? key,
    required this.time,
   this.showDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          showDisabled ? "assets/images/icons/icoFlightDisabled.png" : "assets/images/icons/icoFlightBlack.png",
          width: 32,
          height: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor,
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

  final bool showDisabled;

  const FlightInto({
    Key? key,
    required this.label,
    required this.timeString,
    required this.location,
    this.showDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: kSmallHeavy.copyWith(color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),
        ),
        Text(
          timeString,
          style: kSmallMedium.copyWith(color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),
        ),
        Text(
          location,
          maxLines: 4,
          style: kSmallMedium.copyWith(color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),

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
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'flightDetail.flightChangeReq'.tr(),
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
            padding:  EdgeInsets.only(bottom: 16.0),
            child: Text(
               'flightDetail.flightChangeRules'.tr(),
              style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "• ${'flightChange.rule1'.tr()}\n"
              "• ${'flightChange.rule2'.tr()}\n"
              "• ${'flightChange.rule3'.tr()}\n"
              "• ${'flightChange.rule4'.tr()}.\n"
              "• ${'flightChange.rule5'.tr()}\n"
              "• ${'flightChange.rule6'.tr()}\n"
              "• ${'flightChange.rule7'.tr()}",
              style: kMediumRegular.copyWith(color: Styles.kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'flightChangeProceedFlightChange'.tr(),
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
                    child:  Text('flightDetail.no'.tr()),
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
                    child: Text('flightDetail.yes'.tr()),
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
