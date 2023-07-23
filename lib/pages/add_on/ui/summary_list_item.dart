
import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class SummaryListItem extends StatelessWidget {

  final bool isManageBooking;

  final String text;

  const SummaryListItem({
    Key? key, required this.text, required this.isManageBooking
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "- ",
            style:
            kMediumRegular.copyWith(color: isManageBooking ? Styles.kTextColor : Styles.kActiveGrey),
          ),
          Expanded(
            child: Text(
              text,
              style:
              kMediumRegular.copyWith(color: isManageBooking ? Styles.kTextColor : Styles.kActiveGrey),
            ),
          ),
        ],
      ),
    );
  }
}

