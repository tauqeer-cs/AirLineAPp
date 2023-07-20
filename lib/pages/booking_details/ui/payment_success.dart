import 'package:app/theme/spacer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/ui_utils.dart';

class PaymentSuccessAlert extends StatelessWidget {
  final String currency;
  final String amount;

  const PaymentSuccessAlert(
      {Key? key, required this.currency, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Container(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/icons/circle-tick.png',
              width: 60,
              height: 60,
            ),
          ),

          kVerticalSpacer,

          Text(
            'paymentSuccessful'.tr(),
            textAlign: TextAlign.center,
            style: kHugeHeavy.copyWith(
              color: Styles.kTextColor,
            ),
          ),

          kVerticalSpacer,

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'paymentSuccessMessage1_1'.tr(),
              style: kMediumRegular.copyWith(
                color: Styles.kTextColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '$currency ',
                ),
                TextSpan(
                  text: amount,
                  style: kMediumSemiBold.copyWith(
                    color: Styles.kTextColor,
                  ),
                ),
                TextSpan(
                  text: '${'paymentSuccessMessage1_2'.tr()} ',
                ),
              ],
            ),
          ),

          kVerticalSpacer,

          Text(
            textAlign: TextAlign.center,
            'paymentSuccessMessage2'.tr(),
            style: kMediumRegular.copyWith(
              color: Styles.kTextColor,
            ),
          ),
          kVerticalSpacer,

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                child: Text(
                  'close'.tr(),
                ),
              ),),

              Expanded(
                flex: 2,
                child: Container(),),
            ],
          ),
          kVerticalSpacer,

//
//
          //paymentSuccessMessage2
        ],
      ),
    );
  }
}
