import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../search_result/ui/choose_flight_segment.dart';

class ManageBookingDetailsView extends StatelessWidget {
   ManageBookingDetailsView({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Booking Reference',
                style: kMediumRegular,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                state.pnrEntered ?? '',
                style: kHugeHeavy,
              ),
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
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: state.checkedDeparture,
                            onChanged: (bool? value) {

                              bloc?.setCheckDeparture(value ?? false);


                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Departure',
                                      style: kMediumHeavy.copyWith(
                                          color: Styles.kPrimaryColor),
                                    ),
                                    const Spacer(),
                                    Text(
                                      state.manageBookingResponse?.result
                                              ?.departureDateToShow ??
                                          '',
                                      style: kMediumMedium.copyWith(
                                          color: Styles.kTextColor),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                state.manageBookingResponse?.result
                                        ?.departureToDestinationCode ??
                                    '',
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              kVerticalSpacerMini,
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: FlightInto(
                                      label: 'Depart',
                                      timeString: state.manageBookingResponse
                                              ?.result?.departureDateWithTime ??
                                          '',
                                      location: state.manageBookingResponse?.result
                                              ?.departureAirportName ??
                                          '',
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 4),
                                    child: Expanded(
                                      flex: 3,
                                      child: PlaneWithTime(
                                        time: state.manageBookingResponse?.result
                                                ?.journeyTimeInHourMin ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: FlightInto(
                                      label: 'Arrive',
                                      timeString: state.manageBookingResponse
                                              ?.result?.arrivalDateWithTime ??
                                          '',
                                      location: state.manageBookingResponse?.result
                                              ?.arrivalAirportName ??
                                          '',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              kVerticalSpacerSmall,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Divider(),
                    ),

                    if(state.manageBookingResponse?.result?.flightSegments?.first.inbound != null) ... [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: state.checkReturn,
                              onChanged: (bool? value) {
                                bloc?.setCheckReturn(value ?? false);

                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Return',
                                        style: kMediumHeavy.copyWith(
                                            color: Styles.kPrimaryColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.manageBookingResponse?.result
                                            ?.returnDepartureDateToShow ??
                                            '',
                                        style: kMediumMedium.copyWith(
                                            color: Styles.kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  state.manageBookingResponse?.result
                                      ?.returnToDestinationCode ??
                                      '',
                                  style: kMediumSemiBold.copyWith(
                                      color: Styles.kTextColor),
                                ),
                                kVerticalSpacerMini,
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: FlightInto(
                                        label: 'Depart',
                                        timeString: state.manageBookingResponse
                                            ?.result?.returnDepartureDateWithTime ??
                                            '',
                                        location: state.manageBookingResponse?.result
                                            ?.returnDepartureAirportName ??
                                            '',
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                      child: Expanded(
                                        flex: 3,
                                        child: PlaneWithTime(
                                          time: state.manageBookingResponse?.result
                                              ?.returnJourneyTimeInHourMin ??
                                              '',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: FlightInto(
                                        label: 'Arrive',
                                        timeString: state.manageBookingResponse
                                            ?.result?.returnArrivalDateWithTime ??
                                            '',
                                        location: state.manageBookingResponse?.result
                                            ?.returnArrivalAirportName ??
                                            '',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                                kVerticalSpacerSmall,
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
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
