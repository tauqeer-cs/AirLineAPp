import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class BookingDetailsHeader extends StatelessWidget {
  const BookingDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Booking Details",
          style: kHugeHeavy,
        ),
        kVerticalSpacerSmall,
        Text(
          "Fill in all passengers' names as per passport. Your entry may be denied if your passport's expiry date is within several months of your travel period - please check your passport's expriy date. ",
          style: kMediumRegular.copyWith(
            color: Styles.kSubTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
