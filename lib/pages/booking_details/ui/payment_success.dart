import 'package:app/theme/spacer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/ui_utils.dart';

class PaymentSuccessAlert extends StatelessWidget {
  final String currency;
  final String amount;
  const PaymentSuccessAlert({Key? key, required this.currency, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Container(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/icons/circle-tick.png',
              width: 60,
              height: 60,
            ),
          ),

          kVerticalSpacerSmall,


          Text(
            'paymentSuccessful'.tr(),
            style: kHugeHeavy.copyWith(
              color: Styles.kTextColor,
            ),
          ),

          kVerticalSpacerSmall,

          RichText(
            text: TextSpan(
              text:
              'paymentSuccessMessage1_1'.tr(),
              style:kMediumRegular.copyWith(
                color: Styles.kTextColor,
              ),
              children: <TextSpan>[
                makeClickableTextSpan(context,
                    text: 'Product Disclosure Sheet',
                    pdfIsLink: false),
                makeClickableTextSpan(context,
                    text: ' , understood and agree to the '),
                makeClickableTextSpan(context,
                    text: 'Terms and Conditions',
                    pdfName:
                    'https://booking.myairline.my/insurance/term_and_conditions.pdf',
                    pdfIsLink: true),
                makeClickableTextSpan(context,
                    text:
                    ' of MY Travel Shield and agree to the processing of my Personal Data in accordance with the '),
                makeClickableTextSpan(context,
                    text: 'Data Privacy Notice.',
                    webViewLink: 'https://www.zurich.com.my/pdpa'),
              ],
            ),
          ),

          Text(
            'paymentSuccessMessage1_1'.tr(),
            style: kMediumRegular.copyWith(
              color: Styles.kTextColor,
            ),
          ),

          kVerticalSpacerSmall,

          Text(
            'paymentSuccessMessage2'.tr(),
            style: kMediumRegular.copyWith(
              color: Styles.kTextColor,
            ),
          ),
//
//
        //paymentSuccessMessage2


        ],
      ),
    );
  }
}
