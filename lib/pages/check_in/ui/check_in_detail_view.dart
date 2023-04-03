import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../booking_details/ui/flight_data.dart';
import '../../checkout/pages/booking_details/ui/pessenger_info.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import '../bloc/check_in_cubit.dart';
import 'check_in_steps.dart';

class CheckInDetailView extends StatelessWidget {
  const CheckInDetailView({Key? key}) : super(key: key);

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
    var bloc = context.watch<CheckInCubit>();
    var state = bloc.state;

    return Padding(
      padding: kPageHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const BookingReferenceLabel(
              refText: 'XAS200',
            ),
            SizedBox(
              width: double.infinity,
              child: CheckInSteps(
                passedSteps: const [
                  CheckInStep.itinerary,
                  //            BookingStep.addOn,
//              BookingStep.bookingDetails,
                ],
                onTopStepTaped: (i) {},
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Itinerary',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,
            AppCard(
              edgeInsets: const EdgeInsets.only(right: 15,top: 15,bottom: 15),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: state.checkedDeparture,
                    onChanged: (bool? value) {
                      bloc.setCheckDeparture(value ?? false);
                    },
                  ),
                  Expanded(
                    child: FlightDataInfo(
                      headingLabel: 'Departure',
                      dateToShow: state.manageBookingResponse?.result
                              ?.departureDateToShow ??
                          '',
                      departureToDestinationCode: state.manageBookingResponse
                              ?.result?.departureToDestinationCode ??
                          '',
                      departureDateWithTime: state.manageBookingResponse?.result
                              ?.departureDateWithTime ??
                          '',
                      departureAirportName: state.manageBookingResponse?.result
                              ?.departureAirportName ??
                          '',
                      journeyTimeInHourMin: state.manageBookingResponse?.result
                              ?.journeyTimeInHourMin ??
                          '',
                      arrivalDateWithTime: state.manageBookingResponse?.result
                              ?.arrivalDateWithTime ??
                          '',
                      arrivalAirportName: state.manageBookingResponse?.result
                              ?.arrivalAirportName ??
                          '',
                    ),
                  ),
                ],
              ),
            ),
            kVerticalSpacerSmall,
            if ((state.manageBookingResponse?.isTwoWay ?? false)) ...[
              AppCard(
                edgeInsets: const EdgeInsets.only(right: 15,top: 15,bottom: 15),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: state.checkReturn,
                      onChanged: (bool? value) {
                        bloc.setCheckReturn(value ?? false);
                      },
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
                        departureDateWithTime: state.manageBookingResponse
                                ?.result?.returnDepartureDateWithTime ??
                            '',
                        departureAirportName: state.manageBookingResponse
                                ?.result?.returnDepartureAirportName ??
                            '',
                        journeyTimeInHourMin: state.manageBookingResponse
                                ?.result?.returnJourneyTimeInHourMin ??
                            '',
                        arrivalDateWithTime: state.manageBookingResponse?.result
                                ?.returnArrivalDateWithTime ??
                            '',
                        arrivalAirportName: state.manageBookingResponse?.result
                                ?.returnArrivalAirportName ??
                            '',
                      ),
                    ),
                  ],
                ),
              ),
            ],
            kVerticalSpacer,
            Text(
              'Passenger',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,

            for(int i = 0 ; i < (state.manageBookingResponse?.result?.passengersWithSSR ?? []).length ; i++) ... [
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: state.checkReturn,
                    onChanged: (bool? value) {
                      bloc.setCheckReturn(value ?? false);
                    },
                  ),
                  Text(
                    state.manageBookingResponse?.result?.passengersWithSSR?[i].passengers?.fullName ?? '',
                    style: kLargeHeavy.copyWith(
                      color: Styles.kTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),



                ],
              ),
            ],

            kVerticalSpacer,
            kVerticalSpacer,

          ],
        ),
      ),
    );
  }
}

/*
BookingReferenceLabel(
                      refText: bloc?.state.pnrEntered,
                    ),
* */
