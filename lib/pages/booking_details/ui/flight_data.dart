import 'package:easy_localization/easy_localization.dart';
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

  final bool disabledView;

  const FlightDataInfo(
      {Key? key,
      required this.headingLabel,
      required this.dateToShow,
      required this.departureToDestinationCode,
      required this.departureDateWithTime,
      required this.departureAirportName,
      required this.journeyTimeInHourMin,
      required this.arrivalDateWithTime,
      required this.arrivalAirportName,
      this.disabledView = false,})
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
                style: kMediumHeavy.copyWith(color: disabledView ? Styles.kDisabledGrey : Styles.kPrimaryColor),
              ),
              const Spacer(),
              Text(
                dateToShow,
                style: kMediumMedium.copyWith(color: disabledView ? Styles.kDisabledGrey : Styles.kTextColor),
              ),
            ],
          ),
        ),
        Text(
          departureToDestinationCode,
          style: kMediumSemiBold.copyWith(color: disabledView ? Styles.kDisabledGrey : Styles.kTextColor),
        ),
        kVerticalSpacerMini,
        Row(
          children: [
            Expanded(
              flex: 4,
              child: FlightInto(
                label: 'flightSummary.depart'.tr(),
                timeString: departureDateWithTime,
                location: departureAirportName,
                showDisabled: disabledView,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PlaneWithTime(
                  time: journeyTimeInHourMin,
                  showDisabled: disabledView,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: FlightInto(
                label: 'arrive'.tr(),
                timeString: arrivalDateWithTime,
                location: arrivalAirportName,
                showDisabled: disabledView,

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
