import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class ZurichContainer extends StatelessWidget {
  const ZurichContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return true
        ? Image.asset(
            "assets/images/design/zurich_banner.png",
            width: MediaQuery.of(context).size.width,
          )
        : Container(
            padding: EdgeInsets.all(16),
            color: Color.fromRGBO(130, 211, 208, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/icons/zurich.png",
                  height: 25,
                ),
                kVerticalSpacerSmall,
                Text(
                  "MYAirline Travel Insurance",
                  style: kHugeHeavy,
                ),
                kVerticalSpacerSmall,
                Text(
                  "Without Covid Plan",
                  style: kMediumHeavy.copyWith(color: Styles.kZurichColor),
                ),
                kVerticalSpacerMini,
                RowBulletNumbering(title: "Basic protection for your trip"),
                RowBulletNumbering(title: "Medical expenses up to RM XXX"),
                RowBulletNumbering(title: "Trip cancellation up to RM XXX"),
                kVerticalSpacerSmall,
                Text(
                  "With Covid Plan",
                  style: kMediumHeavy.copyWith(color: Styles.kZurichColor),
                ),
                kVerticalSpacerMini,
                RowBulletNumbering(
                    title:
                        "Enhance protection for your trip with Covid-19 coverage"),
                RowBulletNumbering(title: "Medical Expenses up to RM xxx"),
                RowBulletNumbering(title: "Trip Cancellation up to RM xxx"),
                kVerticalSpacerSmall,
                Center(
                  child: Text(
                    "View all benefits",
                    style: kMediumHeavy.copyWith(
                        color: Styles.kZurichColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          );
  }
}
