import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class AddonHeader extends StatelessWidget {
  const AddonHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add-On",
          style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
        ),
        kVerticalSpacer,
        Text(
          " Your starter fares include 7kg of carry-on baggage. Next, you can purchase additional baggage, select your seat of choice and meal.",
          style: kMediumRegular.copyWith(
            color: Styles.kSubTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
