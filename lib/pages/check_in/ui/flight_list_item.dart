import 'package:flutter/material.dart';

import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/app_card.dart';

class FlightListItem extends StatelessWidget {

  final String dateToShow;

  final String flightCode;

  final String departureLocation;
  final String destinationLocation;

  final VoidCallback onCheckTapped;


  const FlightListItem({Key? key, required this.dateToShow, required this.flightCode, required this.departureLocation, required this.destinationLocation, required this.onCheckTapped}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppCard(
      edgeInsets: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 4,
            ),
            Text(
              dateToShow,
              style: kMediumSemiBold.copyWith(
                  color: Styles.kTextColor),
            ),
            kVerticalSpacerSmall,
            Text(
              flightCode,
              style: kMediumSemiBold.copyWith(
                  color: Styles.kTextColor),
            ),
            kVerticalSpacerSmall,
            Row(
              children: [
                Expanded(
                  child: Text(
                    departureLocation,
                    style: kMediumRegular.copyWith(
                        color: Styles.kTextColor),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset(
                    "assets/images/icons/icoFlightBlack.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                Expanded(
                  child: Text(
                    destinationLocation,
                    textAlign: TextAlign.right,
                    style: kMediumRegular.copyWith(
                        color: Styles.kTextColor),
                  ),
                ),
              ],
            ),
            kVerticalSpacerSmall,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: onCheckTapped,
                    child: const Text('Check-In'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
