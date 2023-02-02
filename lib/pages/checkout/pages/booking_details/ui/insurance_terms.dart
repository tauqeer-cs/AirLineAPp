import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/security_utils.dart';
import '../../../../../utils/ui_utils.dart';
import '../../../../../widgets/pdf_viewer.dart';

class InsuranceTerms extends StatelessWidget {
  const InsuranceTerms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: RichText(
        text: TextSpan(
          text:
          'I acknowledge and agree that the Policy issued is non-cancellable and premium paid is non-refundable, and the Policy does not cover persons who are on any sanction lists and in such event, the Policy will be void and premium is non- refundable.  I confirm that I have read the ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[

            makeClickableTextSpan(context,text: 'Product Disclosure Sheet',pdfName: 'MYTravelShieldDomestic_PDS'),
            makeClickableTextSpan(context,text: ' , understood and agree to the '),
            makeClickableTextSpan(context,text: 'Terms and Conditions',pdfName: 'MYTravelShieldDomestic_PolicyWording'),
            makeClickableTextSpan(context,text: ' of MY Travel Shield and agree to the processing of my Personal Data in accordance with the '),
            makeClickableTextSpan(context,text: 'Data Privacy Notice.',webViewLink: 'https://www.zurich.com.my/pdpa'),

          ],
        ),
      ),
    );
  }
}
