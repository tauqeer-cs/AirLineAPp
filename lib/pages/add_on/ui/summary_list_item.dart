
import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class SummaryListItem extends StatelessWidget {

  final String text;

  const SummaryListItem({
    Key? key, required this.text
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        children: [
          Text(
            "- ",
            style:
            kMediumRegular.copyWith(color: Styles.kActiveGrey),
          ),
          Expanded(
            child: Text(
              text,
              style:
              kMediumRegular.copyWith(color: Styles.kActiveGrey),
            ),
          ),
        ],
      ),
    );
  }
}

