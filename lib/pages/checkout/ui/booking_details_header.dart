import 'package:easy_localization/easy_localization.dart';
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
        Text(
          "Fill in all passenger details as it appears on their passport or government-issued ID. Passport expiry dates are required to be more than 6 months away from the flight date. Otherwise, your entry to the destination country may be denied.",
          style: kMediumRegular.copyWith(
            color: Styles.kSubTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
