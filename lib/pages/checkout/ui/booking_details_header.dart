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
          "bookingDetailDesc".tr(),
          style: kMediumRegular.copyWith(
            color: Styles.kSubTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
