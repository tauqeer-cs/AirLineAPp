import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RewardAndDiscount extends StatelessWidget {
  const RewardAndDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rewards & Discount",
            style: kGiantSemiBold.copyWith(color: Styles.kPrimaryColor),
          ),
          kVerticalSpacerSmall,
          Text(
            "Voucher Code",
            style: kHugeSemiBold,
          ),
          kVerticalSpacerSmall,
          AppCard(
            child: FormBuilderTextField(
              name: "voucherCode",
              decoration: InputDecoration(
                hintText: "Voucher Code",
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                isDense: true,
              ),

            ),
          ),
          kVerticalSpacerSmall,
          ElevatedButton(
            onPressed: () {},
            child: Text("Apply"),
          ),
          // AppCard(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Promo Code",
          //         style: kHugeSemiBold,
          //       ),
          //       kVerticalSpacer,
          //       AppInputText(name: "promoCode"),
          //       kVerticalSpacer,
          //       ElevatedButton(onPressed: () {}, child: Text("Apply")),
          //       kVerticalSpacerBig,
          //       Text(
          //         "Voucher Code",
          //         style: kHugeSemiBold,
          //       ),
          //       kVerticalSpacer,
          //       AppInputText(name: "voucherCode"),
          //       kVerticalSpacer,
          //       ElevatedButton(onPressed: () {}, child: Text("Apply")),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
