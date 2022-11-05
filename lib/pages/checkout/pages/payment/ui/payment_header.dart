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
        const Text(
            "Fill in all passengers’ names as per passport. Your entry may be denied if your passport’s expiry date is within several months of your travel period - please check your passport’s expiry date."),
      ],
    );
  }
}
