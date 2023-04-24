import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Payment",
          style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
        ),
        kVerticalSpacer,
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
