import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class AlertWarningBeforeProceed extends StatelessWidget {
  const AlertWarningBeforeProceed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'flightDetail.flightChangeReq'.tr(),
            textAlign: TextAlign.center,
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'flightDetail.flightChangeRules'.tr(),
              style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "• ${'flightChange.rule1'.tr()}\n"
                  "• ${'flightChange.rule2'.tr()}\n"
                  "• ${'flightChange.rule3'.tr()}\n"
                  "• ${'flightChange.rule4'.tr()}.\n"
                  "• ${'flightChange.rule5'.tr()}\n"
                  "• ${'flightChange.rule6'.tr()}\n"
                  "• ${'flightChange.rule7'.tr()}",
              style: kMediumRegular.copyWith(color: Styles.kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 16),
            child: Text(
              'flightChangeProceedFlightChange'.tr(),
              style: kMediumRegular.copyWith(color: Styles.kTextColor),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, //isLoading ? null :
                    child: Text('flightDetail.no'.tr()),
                    /*
                      * isLoading
                          ? const AppLoading(
                        size: 20,
                      )*/
                  ),
                ),
                kHorizontalSpacerSmall,
                Expanded(
                  child: ElevatedButton(
                    child: Text('flightDetail.yes'.tr()),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

