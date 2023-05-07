import 'package:app/widgets/containers/grey_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GreyCard(
          color: const Color.fromRGBO(235, 235, 235, 0.75),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
               Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Text("forgotPassword2.checkInbox".tr(), style: kGiantHeavy),
              ),
              kVerticalSpacerMini,
              Text(
                "forgotPassword2.checkEmail".tr(),
                style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
              ),
              kVerticalSpacer,
              ElevatedButton(
                onPressed: () {
                  context.router.pop();
                },
                child:  Text("expiredPopup.ok".tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
