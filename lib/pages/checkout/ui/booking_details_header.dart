import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class BookingDetailsHeader extends StatelessWidget {
  const BookingDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "bookingDetails".tr(),
          style: kHugeHeavy,
        ),
        kVerticalSpacerSmall,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Fill in all passenger details as it appears on their passport or government-issued ID. Passport expiry dates are required to be more than",
                style: kMediumRegular.copyWith(
                  color: Styles.kTextColor,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: ' 6 months ',
                style: kMediumHeavy.copyWith(
                  color: Styles.kTextColor,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: 'away from the flight date. Otherwise, your entry to the destination country may be denied.',
                style: kMediumRegular.copyWith(
                  color: Styles.kTextColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),

      ],
    );
  }
}
