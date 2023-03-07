import 'package:flutter/material.dart';

import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import 'booking_details_view.dart';

class FlightDataInfo extends StatelessWidget {
  final String headingLabel;
  final String dateToShow;
  final String departureToDestinationCode;
  final String departureDateWithTime;
  final String departureAirportName;
  final String journeyTimeInHourMin;
  final String arrivalDateWithTime;
  final String arrivalAirportName;

  const FlightDataInfo(
      {Key? key,
      required this.headingLabel,
      required this.dateToShow,
      required this.departureToDestinationCode,
      required this.departureDateWithTime,
      required this.departureAirportName,
      required this.journeyTimeInHourMin,
      required this.arrivalDateWithTime,
      required this.arrivalAirportName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                headingLabel,
                style: kMediumHeavy.copyWith(color: Styles.kPrimaryColor),
              ),
              const Spacer(),
              Text(
                dateToShow,
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        ),
        Text(
          departureToDestinationCode,
          style: kMediumSemiBold.copyWith(color: Styles.kTextColor),
        ),
        kVerticalSpacerMini,
        Row(
          children: [
            Expanded(
              flex: 4,
              child: FlightInto(
                label: 'Depart',
                timeString: departureDateWithTime,
                location: departureAirportName,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PlaneWithTime(
                  time: journeyTimeInHourMin,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: FlightInto(
                label: 'Arrive',
                timeString: arrivalDateWithTime,
                location: arrivalAirportName,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        kVerticalSpacerSmall,
      ],
    );
  }
}
