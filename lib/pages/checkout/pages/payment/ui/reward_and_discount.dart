import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';

class RewardAndDiscount extends StatelessWidget {
  const RewardAndDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          Text(
            "Rewards & Discount",
            style: kGiantSemiBold.copyWith(color: Styles.kPrimaryColor),
          ),
          kVerticalSpacer,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Promo Code",
                  style: kHugeSemiBold,
                ),
                kVerticalSpacer,
                AppInputText(name: "promoCode"),
                kVerticalSpacer,
                ElevatedButton(onPressed: () {}, child: Text("Apply")),
                kVerticalSpacerBig,
                Text(
                  "Voucher Code",
                  style: kHugeSemiBold,
                ),
                kVerticalSpacer,
                AppInputText(name: "voucherCode"),
                kVerticalSpacer,
                ElevatedButton(onPressed: () {}, child: Text("Apply")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
