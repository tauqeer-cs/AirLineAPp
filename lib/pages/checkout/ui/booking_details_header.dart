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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "bookingForm.bookingDetailsDesc1".tr(),
                style: kMediumRegular.copyWith(
                  color: Styles.kTextColor,
                  height: 1.5,
                ),

              ),

              TextSpan(
                text: '  ${'bookingForm.bookingDetailsDesc2'.tr()}',
                style: kMediumHeavy.copyWith(
                  color: Styles.kTextColor,
                  height: 1.5,
                ),
              ),


              TextSpan(
                text: ' ${'bookingForm.bookingDetailsDesc3'.tr()}',
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
