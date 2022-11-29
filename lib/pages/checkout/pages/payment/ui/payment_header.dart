import 'package:app/theme/theme.dart';
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
